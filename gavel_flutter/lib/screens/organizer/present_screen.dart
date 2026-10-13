import 'dart:async';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gavel_client/gavel_client.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import '../../widgets/gavel_logo.dart';
import '../../widgets/join_card.dart';
import '../../widgets/leaderboard_view.dart';

/// Big-screen mode for the expo hall: live top 10, the join QR code, and the
/// ElevenLabs-narrated awards ceremony.
class PresentScreen extends StatefulWidget {
  const PresentScreen({super.key, required this.eventId});
  final int eventId;

  @override
  State<PresentScreen> createState() => _PresentScreenState();
}

class _PresentScreenState extends State<PresentScreen> {
  OrganizerEvent? _view;
  LiveSnapshot? _snap;
  StreamSubscription<LiveSnapshot>? _live;
  Timer? _retry;
  bool _ceremony = false;

  @override
  void initState() {
    super.initState();
    client.organizer.getEvent(widget.eventId).then((v) {
      if (mounted) setState(() => _view = v);
    });
    _subscribe();
  }

  @override
  void dispose() {
    _live?.cancel();
    _retry?.cancel();
    super.dispose();
  }

  void _subscribe() {
    _live?.cancel();
    _live = client.organizer
        .watch(widget.eventId)
        .listen(
          (snap) {
            if (mounted) setState(() => _snap = snap);
          },
          onError: (_) => _scheduleResubscribe(),
          onDone: _scheduleResubscribe,
        );
  }

  void _scheduleResubscribe() {
    _retry?.cancel();
    _retry = Timer(const Duration(seconds: 2), () {
      if (mounted) _subscribe();
    });
  }

  @override
  Widget build(BuildContext context) {
    final view = _view;
    final snap = _snap;
    if (view == null || snap == null) {
      return const Scaffold(body: LoadingView());
    }
    final event = view.event;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 28, 40, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const GavelLogo(size: 48),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          event.name,
                          overflow: TextOverflow.ellipsis,
                          style: G.serif(size: 44),
                        ),
                      ),
                      StatusChip(status: snap.status),
                      const SizedBox(width: 24),
                      _BigStat(label: 'votes', value: '${snap.totalVotes}'),
                      const SizedBox(width: 24),
                      _BigStat(
                        label: 'podium certainty',
                        value: '${(snap.podiumCertainty * 100).round()}%',
                        color: snap.podiumCertainty >= 0.8 ? G.mint : G.brass,
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        tooltip: 'Back to dashboard',
                        onPressed: () => context.go('/events/${event.id}'),
                        icon: const Icon(Icons.close_rounded, color: G.muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: LeaderboardView(
                              entries: snap.leaderboard,
                              limit: 10,
                              rowHeight: 74,
                              big: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),
                        SizedBox(
                          width: 340,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              JoinCard(code: event.judgeCode, big: true),
                              const SizedBox(height: 18),
                              FilledButton.icon(
                                key: const Key('ceremony'),
                                onPressed: () =>
                                    setState(() => _ceremony = true),
                                icon: const Icon(Icons.emoji_events_rounded),
                                label: const Text('Start awards ceremony'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_ceremony)
            Positioned.fill(
              child: _Ceremony(
                eventId: event.id!,
                eventName: event.name,
                onClose: () => setState(() => _ceremony = false),
              ),
            ),
        ],
      ),
    );
  }
}

class _BigStat extends StatelessWidget {
  const _BigStat({
    required this.label,
    required this.value,
    this.color = G.paper,
  });
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        value,
        style: G.mono(size: 30, weight: FontWeight.w700, color: color),
      ),
      Text(label.toUpperCase(), style: G.eyebrow(color: G.muted)),
    ],
  );
}

/// Podium reveal synced (approximately) to the ElevenLabs narration.
class _Ceremony extends StatefulWidget {
  const _Ceremony({
    required this.eventId,
    required this.eventName,
    required this.onClose,
  });

  final int eventId;
  final String eventName;
  final VoidCallback onClose;

  @override
  State<_Ceremony> createState() => _CeremonyState();
}

class _CeremonyState extends State<_Ceremony> with TickerProviderStateMixin {
  final _player = AudioPlayer();
  Announcement? _announcement;
  String? _error;
  int _revealed = 0; // 0..3
  final _timers = <Timer>[];
  late final _confetti = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  @override
  void dispose() {
    for (final t in _timers) {
      t.cancel();
    }
    _player.dispose();
    _confetti.dispose();
    super.dispose();
  }

  Future<void> _prepare() async {
    try {
      final announcement = await client.organizer.announceWinners(
        widget.eventId,
      );
      if (!mounted) return;
      setState(() => _announcement = announcement);
      await _play(announcement);
    } catch (e) {
      if (mounted) setState(() => _error = friendlyError(e));
    }
  }

  Future<void> _play(Announcement a) async {
    var total = const Duration(seconds: 18);
    if (a.audioUrl != null) {
      try {
        await _player.setSourceUrl(a.audioUrl!);
        total = await _player.getDuration() ?? total;
        await _player.resume();
      } catch (_) {
        // Fall back to a silent, timed reveal.
      }
    }
    // Reveal each name roughly when the narrator says it.
    final script = a.script;
    for (var place = 3; place >= 1; place--) {
      final name = a.podium[place - 1].name;
      var index = script.lastIndexOf(name);
      if (index < 0) index = script.length * (4 - place) ~/ 4;
      final at = total * (index / script.length);
      final reveal = 4 - place;
      _timers.add(
        Timer(at, () {
          if (!mounted) return;
          setState(() => _revealed = math.max(_revealed, reveal));
          if (reveal == 3) _confetti.forward(from: 0);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final a = _announcement;
    return Material(
      color: G.ink.withValues(alpha: 0.97),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _confetti,
                builder: (context, _) => CustomPaint(
                  painter: _ConfettiPainter(_confetti.value),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 24,
            child: IconButton(
              onPressed: widget.onClose,
              icon: const Icon(Icons.close_rounded, color: G.muted, size: 30),
            ),
          ),
          Center(
            child: _error != null
                ? CenteredMessage(
                    icon: Icons.emoji_events_outlined,
                    title: 'Not quite yet',
                    body: _error,
                  )
                : a == null
                ? const LoadingView(
                    label: 'Tallying votes and warming up the narrator…',
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('AWARDS CEREMONY', style: G.eyebrow()),
                      const SizedBox(height: 12),
                      Text(widget.eventName, style: G.serif(size: 54)),
                      const SizedBox(height: 10),
                      if (a.audioUrl != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.graphic_eq_rounded,
                              color: G.brass,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Narrated by ElevenLabs',
                              style: G.sans(color: G.muted, size: 14),
                            ),
                          ],
                        ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _Podium(
                            entry: a.podium[1],
                            place: 2,
                            visible: _revealed >= 2,
                          ),
                          const SizedBox(width: 24),
                          _Podium(
                            entry: a.podium[0],
                            place: 1,
                            visible: _revealed >= 3,
                          ),
                          const SizedBox(width: 24),
                          _Podium(
                            entry: a.podium[2],
                            place: 3,
                            visible: _revealed >= 1,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _Podium extends StatelessWidget {
  const _Podium({
    required this.entry,
    required this.place,
    required this.visible,
  });
  final LeaderboardEntry entry;
  final int place;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final color = switch (place) {
      1 => G.brass,
      2 => const Color(0xFFC9CED8),
      _ => const Color(0xFFC98A52),
    };
    final height = switch (place) {
      1 => 250.0,
      2 => 190.0,
      _ => 150.0,
    };
    return SizedBox(
      width: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: const Duration(milliseconds: 600),
            child: AnimatedSlide(
              offset: visible ? Offset.zero : const Offset(0, 0.4),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutBack,
              child: Column(
                children: [
                  Text(
                    entry.name,
                    textAlign: TextAlign.center,
                    style: G.serif(size: place == 1 ? 40 : 30),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    [
                      entry.location,
                      if (entry.team != null) entry.team!,
                    ].join(' · '),
                    textAlign: TextAlign.center,
                    style: G.sans(color: G.muted, size: 15),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            height: visible ? height : 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color, color.withValues(alpha: 0.35)],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 14),
            child: Text(
              visible ? '$place' : '?',
              style: G.serif(
                size: visible ? 64 : 40,
                color: G.ink,
                weight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.t);
  final double t;

  static final _pieces = List.generate(160, (i) {
    final r = math.Random(i * 7919);
    return (
      x: r.nextDouble(),
      speed: 0.35 + r.nextDouble() * 0.65,
      drift: (r.nextDouble() - 0.5) * 0.25,
      spin: r.nextDouble() * 12,
      size: 6 + r.nextDouble() * 8,
      color: const [G.brass, G.mint, G.sky, G.paper, Color(0xFFFF8FA3)][i % 5],
    );
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (t == 0 || t == 1) return;
    for (final p in _pieces) {
      final y = -40 + (size.height + 80) * (t * p.speed * 1.6);
      if (y > size.height + 20) continue;
      final x =
          size.width * (p.x + p.drift * t) + math.sin(t * 10 + p.spin) * 18;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.spin + t * 8);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 0.5,
        ),
        Paint()..color = p.color.withValues(alpha: 1 - t * 0.5),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.t != t;
}
