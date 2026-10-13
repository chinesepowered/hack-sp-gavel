import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gavel_client/gavel_client.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import '../../widgets/gavel_logo.dart';
import 'note_composer.dart';

/// The judge's phone: where to go next and "which was better?".
class JudgeScreen extends StatefulWidget {
  const JudgeScreen({super.key, required this.token});
  final String token;

  @override
  State<JudgeScreen> createState() => _JudgeScreenState();
}

class _JudgeScreenState extends State<JudgeScreen> {
  JudgeState? _state;
  String? _error;
  bool _busy = false;
  StreamSubscription<JudgeState>? _watch;
  Timer? _retry;

  @override
  void initState() {
    super.initState();
    _load();
    _subscribe();
  }

  @override
  void dispose() {
    _watch?.cancel();
    _retry?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final state = await client.judge.state(widget.token);
      if (mounted) setState(() => _state = state);
    } catch (e) {
      if (mounted) setState(() => _error = friendlyError(e));
    }
  }

  /// Server-pushed updates: re-routing, event opened/closed, seat paused.
  void _subscribe() {
    _watch?.cancel();
    _watch = client.judge
        .watch(widget.token)
        .listen(
          (state) {
            if (!mounted) return;
            final changed =
                state.current?.id != _state?.current?.id ||
                state.phase != _state?.phase;
            setState(() => _state = state);
            if (changed && state.notice != null) {
              showInfo(context, state.notice!, icon: Icons.alt_route_rounded);
            }
          },
          onError: (_) => _scheduleResubscribe(),
          onDone: _scheduleResubscribe,
        );
  }

  void _scheduleResubscribe() {
    _retry?.cancel();
    _retry = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      _load();
      _subscribe();
    });
  }

  Future<void> _run(Future<JudgeState> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final state = await action();
      if (mounted) setState(() => _state = state);
    } catch (e) {
      if (mounted) showError(context, friendlyError(e));
      await _load();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _skip() async {
    final reason = await showModalBottomSheet<SkipReason>(
      context: context,
      backgroundColor: G.ink2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Can’t judge this one?', style: G.serif(size: 24)),
              const SizedBox(height: 14),
              for (final (reason, icon, label) in [
                (
                  SkipReason.absent,
                  Icons.person_off_outlined,
                  'Nobody is at the table',
                ),
                (
                  SkipReason.busy,
                  Icons.groups_outlined,
                  'Another judge is already there',
                ),
                (
                  SkipReason.conflict,
                  Icons.handshake_outlined,
                  'Conflict of interest',
                ),
              ])
                ListTile(
                  leading: Icon(icon, color: G.brass),
                  title: Text(label, style: G.sans(weight: FontWeight.w600)),
                  onTap: () => Navigator.pop(context, reason),
                ),
            ],
          ),
        ),
      ),
    );
    if (reason != null) {
      await _run(() => client.judge.skip(widget.token, reason));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = _state;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: _error != null
                ? CenteredMessage(
                    icon: Icons.link_off_rounded,
                    title: 'This link is not valid',
                    body: _error,
                    action: OutlinedButton(
                      onPressed: () => context.go('/join'),
                      child: const Text('Join with a code'),
                    ),
                  )
                : state == null
                ? const LoadingView(label: 'Loading your judging seat…')
                : Column(
                    children: [
                      _Header(state: state),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 380),
                          switchInCurve: Curves.easeOutCubic,
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween(
                                    begin: const Offset(0.08, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              ),
                          child: KeyedSubtree(
                            key: ValueKey(
                              '${state.phase}-${state.current?.id}',
                            ),
                            child: _body(state),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _body(JudgeState state) {
    switch (state.phase) {
      case JudgePhase.ready:
        return _Ready(
          busy: _busy,
          onStart: () => _run(() => client.judge.begin(widget.token)),
        );
      case JudgePhase.visit:
        return _Visit(
          state: state,
          busy: _busy,
          token: widget.token,
          onDone: () => _run(() => client.judge.finishFirstVisit(widget.token)),
          onSkip: _skip,
        );
      case JudgePhase.compare:
        return _Compare(
          state: state,
          busy: _busy,
          token: widget.token,
          onVote: (choice) =>
              _run(() => client.judge.vote(widget.token, choice)),
          onSkip: _skip,
        );
      case JudgePhase.finished:
        return CenteredMessage(
          icon: Icons.emoji_events_outlined,
          title: 'You’ve seen every project',
          body:
              'Thank you! You cast ${state.votesCast} votes. If teams arrive '
              'late, organizers may add more projects.',
          action: OutlinedButton(
            onPressed: _busy
                ? null
                : () => _run(() => client.judge.begin(widget.token)),
            child: const Text('Check for new projects'),
          ),
        );
      case JudgePhase.closed:
        return CenteredMessage(
          icon: state.eventStatus == EventStatus.setup
              ? Icons.hourglass_top_rounded
              : Icons.gavel_rounded,
          title: state.eventStatus == EventStatus.setup
              ? 'Judging opens soon'
              : 'Judging has closed',
          body: state.eventStatus == EventStatus.setup
              ? 'Keep this page open. It updates the moment organizers open '
                    'judging.'
              : 'Thanks for judging ${state.eventName}! You cast '
                    '${state.votesCast} votes.',
        );
      case JudgePhase.inactive:
        return const CenteredMessage(
          icon: Icons.pause_circle_outline_rounded,
          title: 'Your seat is paused',
          body:
              'An organizer paused your judging seat. Find them if you '
              'think this is a mistake.',
        );
    }
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state});
  final JudgeState state;

  @override
  Widget build(BuildContext context) {
    final total = state.projectsTotal == 0 ? 1 : state.projectsTotal;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Column(
        children: [
          Row(
            children: [
              const GavelLogo(size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.eventName,
                      overflow: TextOverflow.ellipsis,
                      style: G.sans(size: 15, weight: FontWeight.w800),
                    ),
                    Text(
                      'Judging as ${state.judgeName}',
                      style: G.sans(size: 12.5, color: G.muted),
                    ),
                  ],
                ),
              ),
              Text(
                '${state.projectsSeen}/${state.projectsTotal}',
                style: G.mono(size: 13, color: G.muted),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: state.projectsSeen / total),
              duration: const Duration(milliseconds: 500),
              builder: (context, v, _) => LinearProgressIndicator(
                value: v,
                minHeight: 4,
                color: G.brass,
                backgroundColor: G.ink3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Ready extends StatelessWidget {
  const _Ready({required this.busy, required this.onStart});
  final bool busy;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const SizedBox(height: 20),
      Text('HOW IT WORKS', style: G.eyebrow()),
      const SizedBox(height: 12),
      Text('No scores. Just comparisons.', style: G.serif(size: 34)),
      const SizedBox(height: 22),
      for (final (n, title, body) in [
        (
          '01',
          'Go where we send you',
          'Gavel picks the table where your opinion helps the ranking most.',
        ),
        (
          '02',
          'Look, ask, listen',
          'Spend a few minutes with the team like you normally would.',
        ),
        (
          '03',
          'Better or worse?',
          'Tell us if it beat the project you saw before. Dictate a note if you like.',
        ),
      ])
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Panel(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  n,
                  style: G.mono(color: G.brass, weight: FontWeight.w700),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: G.sans(size: 16, weight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Text(body, style: G.sans(color: G.muted, height: 1.45)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      const SizedBox(height: 12),
      FilledButton(
        key: const Key('begin'),
        onPressed: busy ? null : onStart,
        child: const Text('Send me to my first table'),
      ),
    ],
  );
}

/// Big "go to this table" card.
class _Destination extends StatelessWidget {
  const _Destination({required this.project, required this.label});
  final ProjectCard project;
  final String label;

  @override
  Widget build(BuildContext context) => Panel(
    padding: const EdgeInsets.all(22),
    borderColor: G.brass.withValues(alpha: 0.45),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: G.eyebrow()),
        const SizedBox(height: 8),
        Text(
          project.location.toUpperCase(),
          style: G.mono(size: 40, weight: FontWeight.w700, color: G.brass),
        ),
        const SizedBox(height: 6),
        Text(project.name, style: G.serif(size: 32)),
        if (project.team != null) ...[
          const SizedBox(height: 6),
          Text(project.team!, style: G.sans(color: G.muted, size: 15)),
        ],
        if (project.description.isNotEmpty) ...[
          const SizedBox(height: 14),
          Text(
            project.description,
            style: G.sans(color: G.paper.withValues(alpha: 0.85), height: 1.5),
          ),
        ],
      ],
    ),
  );
}

class _Visit extends StatelessWidget {
  const _Visit({
    required this.state,
    required this.busy,
    required this.token,
    required this.onDone,
    required this.onSkip,
  });

  final JudgeState state;
  final bool busy;
  final String token;
  final VoidCallback onDone;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _Destination(project: state.current!, label: 'HEAD TO'),
      const SizedBox(height: 14),
      NoteComposer(
        token: token,
        projectId: state.current!.id,
        voiceEnabled: state.voiceNotesEnabled,
      ),
      const SizedBox(height: 18),
      Text(
        'This is your first project, so there is nothing to compare yet.',
        style: G.sans(color: G.muted, size: 14),
      ),
      const SizedBox(height: 12),
      FilledButton(
        key: const Key('done-first'),
        onPressed: busy ? null : onDone,
        child: const Text('Done — next project'),
      ),
      TextButton(
        onPressed: busy ? null : onSkip,
        child: const Text('Can’t judge this one'),
      ),
    ],
  );
}

class _Compare extends StatelessWidget {
  const _Compare({
    required this.state,
    required this.busy,
    required this.token,
    required this.onVote,
    required this.onSkip,
  });

  final JudgeState state;
  final bool busy;
  final String token;
  final ValueChanged<VoteChoice> onVote;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _Destination(project: state.current!, label: 'NOW VISITING'),
      const SizedBox(height: 14),
      NoteComposer(
        token: token,
        projectId: state.current!.id,
        voiceEnabled: state.voiceNotesEnabled,
      ),
      const SizedBox(height: 26),
      Text('After your visit:', style: G.sans(color: G.muted)),
      const SizedBox(height: 6),
      Text('Which was better?', style: G.serif(size: 32)),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: _Choice(
              key: const Key('vote-previous'),
              label: 'PREVIOUS',
              project: state.previous!,
              enabled: !busy,
              onTap: () => onVote(VoteChoice.previous),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _Choice(
              key: const Key('vote-current'),
              label: 'THIS ONE',
              project: state.current!,
              highlight: true,
              enabled: !busy,
              onTap: () => onVote(VoteChoice.current),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      TextButton(
        onPressed: busy ? null : onSkip,
        child: const Text('Can’t judge this one'),
      ),
    ],
  );
}

class _Choice extends StatefulWidget {
  const _Choice({
    super.key,
    required this.label,
    required this.project,
    required this.onTap,
    required this.enabled,
    this.highlight = false,
  });

  final String label;
  final ProjectCard project;
  final VoidCallback onTap;
  final bool enabled;
  final bool highlight;

  @override
  State<_Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<_Choice> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.highlight ? G.brass : G.paper;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 120),
        child: Container(
          height: 170,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: widget.highlight ? G.brass.withValues(alpha: 0.10) : G.ink3,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: accent.withValues(alpha: widget.highlight ? 0.7 : 0.18),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.label, style: G.eyebrow(color: accent)),
              const Spacer(),
              Text(
                widget.project.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: G.serif(size: 24),
              ),
              const SizedBox(height: 6),
              Text(
                widget.project.location,
                style: G.mono(size: 12.5, color: G.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
