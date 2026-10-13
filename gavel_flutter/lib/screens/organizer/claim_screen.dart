import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../client.dart';
import '../../widgets/common.dart';

/// Opened from an admin link: become a co-organizer of the event.
class ClaimScreen extends StatefulWidget {
  const ClaimScreen({super.key, required this.adminKey});
  final String adminKey;

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _claim();
  }

  Future<void> _claim() async {
    try {
      final view = await client.organizer.claimEvent(widget.adminKey);
      if (mounted) context.go('/events/${view.event.id}');
    } catch (e) {
      if (mounted) setState(() => _error = friendlyError(e));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _error == null
        ? const LoadingView(label: 'Joining as co-organizer…')
        : CenteredMessage(
            icon: Icons.key_off_rounded,
            title: 'Admin link not valid',
            body: _error,
            action: OutlinedButton(
              onPressed: () => context.go('/events'),
              child: const Text('Go to my events'),
            ),
          ),
  );
}
