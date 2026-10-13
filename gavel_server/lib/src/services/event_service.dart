import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'codes.dart';
import 'demo_data.dart';
import 'live_service.dart';

/// Event lifecycle shared by endpoints and future calls.
class EventService {
  EventService._();

  static Future<Event> create(
    Session session, {
    required String name,
    String? tagline,
    required UuidValue ownerId,
    bool isDemo = false,
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw GavelException(message: 'Give your event a name.');
    }
    // Codes are random; retry on the (unlikely) unique index collision.
    for (var attempt = 0; attempt < 5; attempt++) {
      try {
        return await Event.db.insertRow(
          session,
          Event(
            name: trimmed,
            tagline: tagline?.trim().isEmpty ?? true ? null : tagline!.trim(),
            slug: slugify(trimmed),
            judgeCode: newJoinCode(),
            adminKey: newSecret(),
            ownerId: ownerId,
            isDemo: isDemo,
            createdAt: DateTime.now().toUtc(),
          ),
        );
      } on DatabaseUniqueViolationException catch (_) {
        if (attempt == 4) rethrow;
      }
    }
    throw StateError('unreachable');
  }

  /// A sandbox event with 24 realistic projects, ready for a simulation.
  static Future<Event> createDemo(Session session, UuidValue ownerId) async {
    final event = await create(
      session,
      name: 'Demo Hackathon 2026',
      tagline: 'Sandbox event: everything here expires after 24 hours',
      ownerId: ownerId,
      isDemo: true,
    );
    await Project.db.insert(session, [
      for (var i = 0; i < demoProjects.length; i++)
        Project(
          eventId: event.id!,
          name: demoProjects[i].name,
          team: demoProjects[i].team,
          location: 'Table ${i + 1}',
          description: demoProjects[i].description,
          simTrueScore: demoProjects[i].quality,
          createdAt: DateTime.now().toUtc(),
        ),
    ]);
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.status,
      'Demo event created with ${demoProjects.length} projects',
    );
    return event;
  }

  static Future<Event> setStatus(
    Session session,
    Event event,
    EventStatus status, {
    String? reason,
  }) async {
    if (event.status == status) return event;
    event.status = status;
    if (status != EventStatus.live) event.simulationRunning = false;
    if (status == EventStatus.closed) event.closesAt = null;
    final updated = await Event.db.updateRow(session, event);

    final label = switch (status) {
      EventStatus.setup => 'Judging moved back to setup',
      EventStatus.live => 'Judging is open',
      EventStatus.closed => 'Judging closed',
    };
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.status,
      reason ?? label,
    );

    // Push the change to every judge phone that is listening.
    final judges = await Judge.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.isSimulated.equals(false),
    );
    for (final judge in judges) {
      await LiveService.notifyJudge(session, judge);
    }
    return updated;
  }

  /// Parses `name, location, team, description, link` lines. A header line is
  /// skipped; quoted fields may contain commas.
  static List<ProjectInput> parseProjectsCsv(String text) {
    final inputs = <ProjectInput>[];
    var line = 0;
    for (final raw in text.split(RegExp(r'\r?\n'))) {
      line++;
      if (raw.trim().isEmpty) continue;
      final cells = _splitCsvLine(raw);
      if (line == 1 && cells.first.trim().toLowerCase() == 'name') continue;
      final name = cells.isNotEmpty ? cells[0].trim() : '';
      if (name.isEmpty) continue;
      String? cell(int i) => i < cells.length && cells[i].trim().isNotEmpty
          ? cells[i].trim()
          : null;
      inputs.add(
        ProjectInput(
          name: name,
          location: cell(1) ?? 'Table ${inputs.length + 1}',
          team: cell(2),
          description: cell(3) ?? '',
          link: cell(4),
        ),
      );
    }
    return inputs;
  }

  static List<String> _splitCsvLine(String line) {
    final cells = <String>[];
    final buffer = StringBuffer();
    var inQuotes = false;
    for (var i = 0; i < line.length; i++) {
      final char = line[i];
      if (char == '"') {
        if (inQuotes && i + 1 < line.length && line[i + 1] == '"') {
          buffer.write('"');
          i++;
        } else {
          inQuotes = !inQuotes;
        }
      } else if (char == ',' && !inQuotes) {
        cells.add(buffer.toString());
        buffer.clear();
      } else {
        buffer.write(char);
      }
    }
    cells.add(buffer.toString());
    return cells;
  }

  static String exportCsv(Event event, List<LeaderboardEntry> leaderboard) {
    String q(String? v) => '"${(v ?? '').replaceAll('"', '""')}"';
    final rows = [
      'rank,name,location,team,score,uncertainty,podium_probability,'
          'times_seen,wins,losses,active',
      for (final e in leaderboard)
        [
          e.rank,
          q(e.name),
          q(e.location),
          q(e.team),
          e.mu.toStringAsFixed(4),
          e.sigma.toStringAsFixed(4),
          e.podiumProbability.toStringAsFixed(3),
          e.timesSeen,
          e.wins,
          e.losses,
          e.active,
        ].join(','),
    ];
    return rows.join('\n');
  }
}
