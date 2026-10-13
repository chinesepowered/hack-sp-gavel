import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import '../../widgets/gavel_logo.dart';

/// One click from the landing page to a fully populated sandbox event.
class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    setState(() => _error = null);
    try {
      await ensureSignedIn();
      final demo = await client.organizer.createDemoEvent();
      if (mounted) context.go('/events/${demo.event.id}?tour=1');
    } catch (e) {
      if (mounted) setState(() => _error = friendlyError(e));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _error != null
        ? CenteredMessage(
            icon: Icons.cloud_off_rounded,
            title: 'Could not create the demo',
            body: _error,
            action: FilledButton(onPressed: _start, child: const Text('Retry')),
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GavelLogo(size: 64),
                const SizedBox(height: 28),
                Text(
                  'Setting up your sandbox hackathon',
                  style: G.serif(size: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  '24 projects, a judge QR code and a simulation button.',
                  style: G.sans(color: G.muted),
                ),
                const SizedBox(height: 28),
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: G.brass,
                  ),
                ),
              ],
            ),
          ),
  );
}
