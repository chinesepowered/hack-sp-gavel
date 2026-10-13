import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'elevenlabs.dart';
import 'live_service.dart';

/// Builds the awards ceremony script from the final ranking and narrates it
/// with ElevenLabs. The MP3 is stored in Serverpod cloud storage (public) and
/// cached by script hash, so re-opening the ceremony costs nothing.
class AnnouncementService {
  AnnouncementService._();

  static Future<Announcement> announce(Session session, Event event) async {
    final projects = await Project.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.active.equals(true),
    );
    final votes = await Vote.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!),
    );
    final judgeCount = await Judge.db.count(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.votesCast.notEquals(0),
    );
    final leaderboard = LiveService.buildLeaderboard(
      projects,
      votes,
      activeOnly: true,
    );
    if (leaderboard.length < 3 || votes.isEmpty) {
      throw GavelException(
        message: 'You need at least three ranked projects for a ceremony.',
      );
    }
    final podium = leaderboard.take(3).toList();
    final script = buildScript(
      eventName: event.name,
      voteCount: votes.length,
      judgeCount: judgeCount,
      podium: podium,
    );

    String? audioUrl;
    final voice = ElevenLabs.fromSession(session);
    if (voice != null) {
      final hash = sha1
          .convert(utf8.encode(script))
          .toString()
          .substring(0, 16);
      final path = 'announcements/${event.id}-$hash.mp3';
      try {
        final exists = await session.storage.fileExists(
          storageId: 'public',
          path: path,
        );
        if (!exists) {
          final Uint8List mp3 = await voice.speak(script);
          await session.storage.storeFile(
            storageId: 'public',
            path: path,
            byteData: ByteData.sublistView(mp3),
          );
        }
        audioUrl = (await session.storage.publicDownloadUrl(
          storageId: 'public',
          path: path,
        )).toString();
      } catch (e, stackTrace) {
        session.log(
          'Could not narrate the announcement',
          level: LogLevel.warning,
          exception: e,
          stackTrace: stackTrace,
        );
      }
    }

    event
      ..announcementScript = script
      ..announcementUrl = audioUrl;
    await Event.db.updateRow(session, event);
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.status,
      'Awards ceremony prepared${audioUrl == null ? '' : ' with an ElevenLabs narration'}',
    );
    return Announcement(script: script, audioUrl: audioUrl, podium: podium);
  }

  static String buildScript({
    required String eventName,
    required int voteCount,
    required int judgeCount,
    required List<LeaderboardEntry> podium,
  }) {
    String credit(LeaderboardEntry e) =>
        e.team == null ? e.name : '${e.name}, by ${e.team}';
    return 'Judges, hackers, and friends of $eventName. '
        'After $voteCount head-to-head comparisons from $judgeCount judges, '
        'the results are in. '
        'In third place: ${credit(podium[2])}. '
        'In second place: ${credit(podium[1])}. '
        'And the winner of $eventName is... ${credit(podium[0])}! '
        'Congratulations to every team that built something real this weekend.';
  }
}
