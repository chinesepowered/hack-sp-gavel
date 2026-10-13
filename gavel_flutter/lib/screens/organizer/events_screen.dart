import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gavel_client/gavel_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import '../../widgets/gavel_logo.dart';

/// The organizer's events.
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<EventSummary>? _events;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final events = await client.organizer.myEvents();
      if (mounted) setState(() => _events = events);
    } catch (e) {
      if (mounted) setState(() => _error = friendlyError(e));
    }
  }

  Future<void> _create() async {
    final name = TextEditingController();
    final tagline = TextEditingController();
    final created = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New event', style: G.serif(size: 26)),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Event name',
                  hintText: 'Hack the Harbour 2026',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: tagline,
                decoration: const InputDecoration(
                  labelText: 'Tagline (optional)',
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
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (created != true) return;
    try {
      final view = await client.organizer.createEvent(
        name.text,
        tagline.text.isEmpty ? null : tagline.text,
      );
      if (mounted) context.go('/events/${view.event.id}');
    } catch (e) {
      if (mounted) showError(context, friendlyError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = _events;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: ListView(
              padding: const EdgeInsets.all(28),
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.go('/'),
                      child: const GavelWordmark(size: 32),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () async {
                        await client.auth.signOutDevice();
                      },
                      icon: const Icon(Icons.logout_rounded, size: 18),
                      label: const Text('Sign out'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text('ORGANIZER CONSOLE', style: G.eyebrow()),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    Text('Your events', style: G.serif(size: 40)),
                    FilledButton.icon(
                      onPressed: _create,
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('New event'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/demo'),
                      icon: const Icon(Icons.science_outlined, size: 18),
                      label: const Text('New demo sandbox'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                if (_error != null)
                  CenteredMessage(title: 'Could not load events', body: _error)
                else if (events == null)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: LoadingView(),
                  )
                else if (events.isEmpty)
                  Panel(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No events yet', style: G.serif(size: 26)),
                        const SizedBox(height: 8),
                        Text(
                          'Create your event, import projects from a CSV and '
                          'share the judge QR code. Or spin up a sandbox to '
                          'see Gavel in action first.',
                          style: G.sans(color: G.muted, height: 1.5),
                        ),
                      ],
                    ),
                  )
                else
                  for (final e in events)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _EventTile(event: e),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});
  final EventSummary event;

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(18),
    onTap: () => context.go('/events/${event.id}'),
    child: Panel(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        event.name,
                        overflow: TextOverflow.ellipsis,
                        style: G.serif(size: 24),
                      ),
                    ),
                    if (event.isDemo) ...[
                      const SizedBox(width: 10),
                      Text('SANDBOX', style: G.eyebrow(color: G.sky)),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${event.projectCount} projects · ${event.judgeCount} '
                  'judges · ${event.voteCount} votes',
                  style: G.mono(size: 13, color: G.muted),
                ),
              ],
            ),
          ),
          StatusChip(status: event.status),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: G.muted),
        ],
      ),
    ),
  );
}
