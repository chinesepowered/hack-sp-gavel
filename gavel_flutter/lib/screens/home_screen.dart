import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/gavel_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _join() {
    final code = _code.text.trim().toUpperCase();
    if (code.length < 4) return;
    context.go('/join/$code');
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 900;
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const GavelWordmark(size: 42),
        const SizedBox(height: 40),
        Text('FAIR, LIVE HACKATHON JUDGING', style: G.eyebrow()),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Better or worse?\n'),
              TextSpan(
                text: 'That’s the whole rubric.',
                style: G.serif(
                  size: wide ? 58 : 40,
                  style: FontStyle.italic,
                  weight: FontWeight.w500,
                  color: G.brass,
                ),
              ),
            ],
          ),
          style: G.serif(size: wide ? 58 : 40),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'Judges compare projects two at a time on their phones. Gavel '
            'decides where each judge should walk next, learns which judges '
            'to trust, and streams a live, statistically honest leaderboard '
            'to organizers.',
            style: G.sans(size: 17, color: G.muted, height: 1.55),
          ),
        ),
      ],
    );

    final actions = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Panel(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('JUDGING TODAY?', style: G.eyebrow()),
                const SizedBox(height: 10),
                Text('Enter your event code', style: G.serif(size: 24)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _code,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9]'),
                          ),
                          LengthLimitingTextInputFormatter(8),
                        ],
                        style: G.mono(size: 22, weight: FontWeight.w600),
                        decoration: const InputDecoration(hintText: 'K7Q2XD'),
                        onSubmitted: (_) => _join(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(onPressed: _join, child: const Text('Join')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Panel(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('ORGANIZING?', style: G.eyebrow()),
                const SizedBox(height: 10),
                Text('Run judging for your event', style: G.serif(size: 24)),
                const SizedBox(height: 18),
                FilledButton.icon(
                  key: const Key('try-demo'),
                  onPressed: () => context.go('/demo'),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Try the 60-second demo'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () => context.go('/events'),
                  child: const Text('Open the organizer console'),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          const _Glow(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 40,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: intro),
                            const SizedBox(width: 60),
                            actions,
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            intro,
                            const SizedBox(height: 36),
                            actions,
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow();

  @override
  Widget build(BuildContext context) => Positioned(
    top: -260,
    right: -200,
    child: IgnorePointer(
      child: Container(
        width: 820,
        height: 820,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Color(0x33E9B949), Color(0x00E9B949)],
          ),
        ),
      ),
    ),
  );
}
