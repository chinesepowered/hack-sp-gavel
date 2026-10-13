import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import '../../widgets/gavel_logo.dart';

/// Shows [child] to signed-in organizers, and Serverpod's sign-in UI
/// (email or "continue without account") to everyone else.
class OrganizerGate extends StatefulWidget {
  const OrganizerGate({super.key, required this.child});
  final Widget child;

  @override
  State<OrganizerGate> createState() => _OrganizerGateState();
}

class _OrganizerGateState extends State<OrganizerGate> {
  bool _signedIn = client.auth.isAuthenticated;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_update);
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_update);
    super.dispose();
  }

  void _update() => setState(() => _signedIn = client.auth.isAuthenticated);

  @override
  Widget build(BuildContext context) {
    if (_signedIn) return widget.child;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => context.go('/'),
                    child: const GavelWordmark(size: 32),
                  ),
                  const SizedBox(height: 32),
                  Text('ORGANIZER CONSOLE', style: G.eyebrow()),
                  const SizedBox(height: 10),
                  Text('Sign in to run judging', style: G.serif(size: 34)),
                  const SizedBox(height: 12),
                  Text(
                    'Use your email so you can come back from any device, or '
                    'continue without an account to try things out.',
                    style: G.sans(color: G.muted, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Theme(
                      data: ThemeData(
                        brightness: Brightness.light,
                        useMaterial3: true,
                        colorSchemeSeed: G.brass2,
                      ),
                      child: SignInWidget(
                        client: client,
                        onError: (error) =>
                            showError(context, 'Sign in failed: $error'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
