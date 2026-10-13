import 'package:flutter/material.dart';
import 'package:gavel_client/gavel_client.dart';

import '../client.dart';
import '../theme.dart';
import 'common.dart';

/// Manage projects: add, import CSV, pause absent teams, prioritize.
class ProjectsView extends StatefulWidget {
  const ProjectsView({
    super.key,
    required this.eventId,
    required this.refreshKey,
  });

  final int eventId;

  /// Changes whenever the live snapshot changes, so the list stays fresh.
  final Object refreshKey;

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  List<Project>? _projects;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant ProjectsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshKey != widget.refreshKey) _load();
  }

  Future<void> _load() async {
    try {
      final projects = await client.organizer.projects(widget.eventId);
      if (mounted) setState(() => _projects = projects);
    } catch (e) {
      if (mounted) showError(context, friendlyError(e));
    }
  }

  Future<void> _act(Future<Object?> Function() action) async {
    try {
      await action();
      await _load();
    } catch (e) {
      if (mounted) showError(context, friendlyError(e));
    }
  }

  Future<void> _add() async {
    final name = TextEditingController();
    final location = TextEditingController();
    final team = TextEditingController();
    final description = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add a project', style: G.serif(size: 24)),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Project name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: location,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Table 12',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: team,
                decoration: const InputDecoration(labelText: 'Team'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: description,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await _act(
      () => client.organizer.addProject(
        widget.eventId,
        ProjectInput(
          name: name.text,
          location: location.text,
          team: team.text,
          description: description.text,
        ),
      ),
    );
  }

  Future<void> _import() async {
    final text = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Import projects', style: G.serif(size: 24)),
        content: SizedBox(
          width: 560,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paste CSV rows: name, location, team, description, link. '
                'Exports from Devpost or a spreadsheet work.',
                style: G.sans(color: G.muted, size: 13.5),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: text,
                maxLines: 10,
                style: G.mono(size: 12.5),
                decoration: const InputDecoration(
                  hintText:
                      'name,location,team,description\nRipple,Table 1,Tidewater,Flood early warning',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Import'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await _act(() async {
      final count = await client.organizer.importProjects(
        widget.eventId,
        text.text,
      );
      if (mounted) showInfo(context, 'Imported $count projects');
      return count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final projects = _projects;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: _add,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Add project'),
            ),
            OutlinedButton.icon(
              onPressed: _import,
              icon: const Icon(Icons.upload_file_rounded, size: 18),
              label: const Text('Import CSV'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (projects == null)
          const Padding(padding: EdgeInsets.all(24), child: LoadingView())
        else
          for (final p in projects)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: G.ink2,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: G.line),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 86,
                    child: Text(
                      p.location,
                      style: G.mono(size: 12.5, color: G.brass),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: G.sans(size: 15, weight: FontWeight.w800),
                        ),
                        Text(
                          [
                            if (p.team != null) p.team!,
                            '${p.timesSeen} views',
                            if (p.absentReports > 0)
                              '${p.absentReports} absent reports',
                          ].join(' · '),
                          style: G.sans(size: 12.5, color: G.muted),
                        ),
                      ],
                    ),
                  ),
                  Tooltip(
                    message: 'Prioritize: send judges here first',
                    child: IconButton(
                      onPressed: () => _act(
                        () => client.organizer.setProjectPrioritized(
                          p.id!,
                          !p.prioritized,
                        ),
                      ),
                      icon: Icon(
                        p.prioritized
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: p.prioritized ? G.brass : G.muted,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: p.active
                        ? 'Active (pause if the team is absent)'
                        : 'Paused',
                    child: Switch(
                      value: p.active,
                      onChanged: (v) => _act(
                        () => client.organizer.setProjectActive(p.id!, v),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Remove',
                    onPressed: () =>
                        _act(() => client.organizer.deleteProject(p.id!)),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: G.muted,
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

/// Bottom sheet with everything known about one project.
Future<void> showProjectDetail(BuildContext context, int projectId) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: G.ink2,
    constraints: const BoxConstraints(maxWidth: 720),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (context) => FutureBuilder<ProjectDetail>(
      future: client.organizer.projectDetail(projectId),
      builder: (context, snapshot) {
        final detail = snapshot.data;
        if (detail == null) {
          return const SizedBox(height: 260, child: LoadingView());
        }
        final p = detail.project;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.92,
          builder: (context, scroll) => ListView(
            controller: scroll,
            padding: const EdgeInsets.all(26),
            children: [
              Text(
                '#${detail.rank} · ${p.location.toUpperCase()}',
                style: G.eyebrow(),
              ),
              const SizedBox(height: 8),
              Text(p.name, style: G.serif(size: 34)),
              if (p.team != null)
                Text(p.team!, style: G.sans(color: G.muted, size: 15)),
              const SizedBox(height: 14),
              Text(p.description, style: G.sans(height: 1.5)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _Fact('Score', p.mu.toStringAsFixed(2)),
                  _Fact('±', detail.sigma.toStringAsFixed(2)),
                  _Fact('Wins', '${detail.wins}'),
                  _Fact('Losses', '${detail.losses}'),
                  _Fact('Views', '${p.timesSeen}'),
                ],
              ),
              const SizedBox(height: 26),
              Text('JUDGE NOTES', style: G.eyebrow()),
              const SizedBox(height: 10),
              if (detail.notes.isEmpty)
                Text('No notes yet.', style: G.sans(color: G.muted)),
              for (final note in detail.notes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Panel(
                    color: G.ink,
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              note.source == NoteSource.voice
                                  ? Icons.mic_rounded
                                  : Icons.edit_note_rounded,
                              size: 16,
                              color: note.source == NoteSource.voice
                                  ? G.sky
                                  : G.muted,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              note.judgeName,
                              style: G.sans(size: 13, weight: FontWeight.w800),
                            ),
                            if (note.source == NoteSource.voice) ...[
                              const SizedBox(width: 8),
                              Text(
                                'TRANSCRIBED BY ELEVENLABS',
                                style: G.eyebrow(color: G.sky),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(note.text, style: G.sans(height: 1.45)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    ),
  );
}

class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: G.ink3,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: G.eyebrow(color: G.muted)),
        const SizedBox(height: 4),
        Text(value, style: G.mono(size: 18, weight: FontWeight.w700)),
      ],
    ),
  );
}
