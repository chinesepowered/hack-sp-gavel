import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gavel_client/gavel_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/activity_feed.dart';
import '../../widgets/common.dart';
import '../../widgets/gavel_logo.dart';
import '../../widgets/insights_view.dart';
import '../../widgets/join_card.dart';
import '../../widgets/judges_view.dart';
import '../../widgets/leaderboard_view.dart';
import '../../widgets/projects_view.dart';

/// The organizer's live control room.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.eventId, this.tour = false});

  final int eventId;
  final bool tour;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 4, vsync: this);
  OrganizerEvent? _view;
  LiveSnapshot? _snap;
  String? _error;
  StreamSubscription<LiveSnapshot>? _live;
  Timer? _retry;
  Timer? _clock;
  DateTime _now = DateTime.now().toUtc();
  bool _busy = false;
  int _simJudges = 12;

  Event? get _event => _view?.event;

  @override
  void initState() {
    super.initState();
    _load();
    _subscribe();
    _clock = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now().toUtc());
    });
    _tabs.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _live?.cancel();
    _retry?.cancel();
    _clock?.cancel();
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final view = await client.organizer.getEvent(widget.eventId);
      if (mounted) setState(() => _view = view);
    } catch (e) {
      if (mounted) setState(() => _error = friendlyError(e));
    }
  }

  /// Live snapshots over Serverpod streaming (WebSocket).
  void _subscribe() {
    _live?.cancel();
    _live = client.organizer
        .watch(widget.eventId)
        .listen(
          (snap) {
            if (!mounted) return;
            final statusChanged =
                snap.status != _event?.status ||
                snap.simulationRunning != _event?.simulationRunning ||
                snap.resultsPublished != _event?.resultsPublished;
            setState(() => _snap = snap);
            if (statusChanged) _load();
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

  Future<void> _act(Future<OrganizerEvent?> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final view = await action();
      if (mounted && view != null) setState(() => _view = view);
    } catch (e) {
      if (mounted) showError(context, friendlyError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _menu(String value) async {
    final event = _event!;
    switch (value) {
      case 'close15':
      case 'close30':
      case 'close60':
        final minutes = int.parse(value.substring(5));
        await _act(
          () => client.organizer.scheduleClose(
            event.id!,
            DateTime.now().toUtc().add(Duration(minutes: minutes)),
          ),
        );
      case 'closeCancel':
        await _act(() => client.organizer.scheduleClose(event.id!, null));
      case 'publish':
        await _act(
          () => client.organizer.publishResults(
            event.id!,
            !event.resultsPublished,
          ),
        );
      case 'openResults':
        await launchUrl(Uri.parse(resultsUrl(event.slug)));
      case 'export':
        final csv = await client.organizer.exportCsv(event.id!);
        if (!mounted) return;
        await Clipboard.setData(ClipboardData(text: csv));
        if (mounted) showInfo(context, 'Results CSV copied to the clipboard');
      case 'admin':
        await Clipboard.setData(
          ClipboardData(text: '${webOrigin()}/app/#/claim/${_view!.adminKey}'),
        );
        if (mounted) showInfo(context, 'Co-organizer link copied');
      case 'delete':
        final ok = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete ${event.name}?', style: G.serif(size: 24)),
            content: const Text('All projects, judges and votes are removed.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: G.signal),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        if (ok == true) {
          await client.organizer.deleteEvent(event.id!);
          if (mounted) context.go('/events');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        body: CenteredMessage(
          icon: Icons.lock_outline_rounded,
          title: 'Can’t open this event',
          body: _error,
          action: OutlinedButton(
            onPressed: () => context.go('/events'),
            child: const Text('Back to my events'),
          ),
        ),
      );
    }
    final event = _event;
    final snap = _snap;
    if (event == null || snap == null) {
      return const Scaffold(body: LoadingView(label: 'Opening control room…'));
    }

    final width = MediaQuery.sizeOf(context).width;
    final wide = width >= 1280;
    final medium = width >= 900;

    final main = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _kpis(snap, medium),
        const SizedBox(height: 18),
        TabBar(
          controller: _tabs,
          isScrollable: !medium,
          tabAlignment: medium ? TabAlignment.fill : TabAlignment.start,
          tabs: [
            Tab(text: 'Leaderboard (${snap.leaderboard.length})'),
            const Tab(text: 'Projects'),
            Tab(text: 'Judges (${snap.judges.length})'),
            const Tab(text: 'Insights'),
          ],
        ),
        const SizedBox(height: 16),
        _tabBody(event, snap),
      ],
    );

    final side = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        JoinCard(code: event.judgeCode),
        if (event.closesAt != null) ...[
          const SizedBox(height: 14),
          _closesCard(event.closesAt!),
        ],
      ],
    );

    final feed = Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('LIVE ACTIVITY', style: G.eyebrow()),
              const Spacer(),
              if (snap.status == EventStatus.live) const PulseDot(size: 7),
            ],
          ),
          const SizedBox(height: 12),
          ActivityFeed(items: snap.activity, now: _now),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: medium ? 28 : 16,
            vertical: 18,
          ),
          children: [
            _topBar(event, snap, medium),
            const SizedBox(height: 18),
            if (event.isDemo) ...[
              _demoBanner(event),
              const SizedBox(height: 18),
            ],
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 280, child: side),
                  const SizedBox(width: 22),
                  Expanded(child: main),
                  const SizedBox(width: 22),
                  SizedBox(width: 320, child: feed),
                ],
              )
            else if (medium)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: main),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [side, const SizedBox(height: 16), feed],
                    ),
                  ),
                ],
              )
            else ...[
              side,
              const SizedBox(height: 16),
              main,
              const SizedBox(height: 16),
              feed,
            ],
          ],
        ),
      ),
    );
  }

  Widget _topBar(Event event, LiveSnapshot snap, bool medium) {
    final primary = switch (event.status) {
      EventStatus.setup => FilledButton.icon(
        key: const Key('open-judging'),
        onPressed: _busy
            ? null
            : () => _act(
                () => client.organizer.setStatus(event.id!, EventStatus.live),
              ),
        icon: const Icon(Icons.play_arrow_rounded),
        label: const Text('Open judging'),
      ),
      EventStatus.live => FilledButton.icon(
        style: FilledButton.styleFrom(backgroundColor: G.paper),
        onPressed: _busy
            ? null
            : () => _act(
                () => client.organizer.setStatus(event.id!, EventStatus.closed),
              ),
        icon: const Icon(Icons.gavel_rounded),
        label: const Text('Close judging'),
      ),
      EventStatus.closed => OutlinedButton.icon(
        onPressed: _busy
            ? null
            : () => _act(
                () => client.organizer.setStatus(event.id!, EventStatus.live),
              ),
        icon: const Icon(Icons.replay_rounded),
        label: const Text('Reopen'),
      ),
    };

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 14,
      spacing: 14,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'My events',
              onPressed: () => context.go('/events'),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const SizedBox(width: 4),
            const GavelLogo(size: 36),
            const SizedBox(width: 14),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: medium ? 560 : 240),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    overflow: TextOverflow.ellipsis,
                    style: G.serif(size: medium ? 30 : 22),
                  ),
                  if (event.tagline != null)
                    Text(
                      event.tagline!,
                      overflow: TextOverflow.ellipsis,
                      style: G.sans(size: 13, color: G.muted),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            StatusChip(status: event.status),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton.icon(
              key: const Key('present'),
              onPressed: () => context.go('/events/${event.id}/present'),
              icon: const Icon(Icons.tv_rounded, size: 18),
              label: const Text('Present'),
            ),
            const SizedBox(width: 10),
            primary,
            PopupMenuButton<String>(
              tooltip: 'More',
              color: G.ink3,
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: _menu,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'close15',
                  child: Text('Auto-close judging in 15 min'),
                ),
                const PopupMenuItem(
                  value: 'close30',
                  child: Text('Auto-close judging in 30 min'),
                ),
                const PopupMenuItem(
                  value: 'close60',
                  child: Text('Auto-close judging in 60 min'),
                ),
                if (event.closesAt != null)
                  const PopupMenuItem(
                    value: 'closeCancel',
                    child: Text('Cancel automatic close'),
                  ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'publish',
                  child: Text(
                    event.resultsPublished
                        ? 'Hide public results page'
                        : 'Publish public results page',
                  ),
                ),
                if (event.resultsPublished)
                  const PopupMenuItem(
                    value: 'openResults',
                    child: Text('Open public results page'),
                  ),
                const PopupMenuItem(
                  value: 'export',
                  child: Text('Copy results as CSV'),
                ),
                const PopupMenuItem(
                  value: 'admin',
                  child: Text('Copy co-organizer link'),
                ),
                if (_view!.isOwner) ...[
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete event'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _demoBanner(Event event) {
    final running = event.simulationRunning;
    return Panel(
      color: G.sky.withValues(alpha: 0.07),
      borderColor: G.sky.withValues(alpha: 0.35),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          Icon(
            running ? Icons.directions_walk_rounded : Icons.science_outlined,
            color: G.sky,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              running
                  ? 'Simulation running: $_simJudges judges are walking the '
                        'floor. One of them, Chaos Carl, votes against the '
                        'consensus. Watch Crowd-BT catch him in the Judges tab.'
                  : 'Sandbox event. Simulate a judging floor, then scan the QR '
                        'code to judge alongside the simulated judges.',
              style: G.sans(size: 14, height: 1.4),
            ),
          ),
          if (!running) ...[
            DropdownButton<int>(
              value: _simJudges,
              dropdownColor: G.ink3,
              underline: const SizedBox(),
              style: G.sans(weight: FontWeight.w700),
              items: [
                for (final n in [6, 8, 12, 16])
                  DropdownMenuItem(value: n, child: Text('$n judges')),
              ],
              onChanged: (v) => setState(() => _simJudges = v ?? 12),
            ),
            FilledButton.icon(
              key: const Key('start-simulation'),
              onPressed: _busy
                  ? null
                  : () => _act(
                      () => client.organizer.startSimulation(
                        event.id!,
                        _simJudges,
                      ),
                    ),
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Start simulation'),
            ),
          ] else
            OutlinedButton.icon(
              onPressed: _busy
                  ? null
                  : () =>
                        _act(() => client.organizer.stopSimulation(event.id!)),
              icon: const Icon(Icons.stop_rounded),
              label: const Text('Stop'),
            ),
        ],
      ),
    );
  }

  Widget _kpis(LiveSnapshot snap, bool medium) {
    final tiles = [
      KpiTile(label: 'Votes cast', value: '${snap.totalVotes}'),
      KpiTile(
        label: 'Judges on the floor',
        value: '${snap.activeJudges}/${snap.judges.length}',
      ),
      KpiTile(
        label: 'Coverage',
        value: '${(snap.coverage * 100).round()}%',
        progress: snap.coverage,
        accent: G.sky,
        hint:
            'Share of active projects that reached the minimum number of '
            'views. Average: ${snap.averageViews.toStringAsFixed(1)} views.',
      ),
      KpiTile(
        label: 'Podium certainty',
        value: '${(snap.podiumCertainty * 100).round()}%',
        progress: snap.podiumCertainty,
        accent: snap.podiumCertainty >= 0.8 ? G.mint : G.brass,
        hint:
            'Probability that the current top 3 is the true top 3, '
            'estimated by Monte Carlo over the Crowd-BT posteriors.',
      ),
    ];
    if (!medium) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.6,
        children: tiles,
      );
    }
    return Row(
      children: [
        for (var i = 0; i < tiles.length; i++) ...[
          if (i > 0) const SizedBox(width: 14),
          Expanded(child: tiles[i]),
        ],
      ],
    );
  }

  Widget _tabBody(Event event, LiveSnapshot snap) {
    switch (_tabs.index) {
      case 0:
        return LeaderboardView(
          entries: snap.leaderboard,
          onTap: (e) => showProjectDetail(context, e.projectId),
        );
      case 1:
        return ProjectsView(
          eventId: event.id!,
          refreshKey: snap.leaderboard.length,
        );
      case 2:
        return JudgesView(eventId: event.id!, judges: snap.judges);
      default:
        return InsightsView(eventId: event.id!, snapshot: snap);
    }
  }

  Widget _closesCard(DateTime closesAt) {
    final left = closesAt.difference(_now);
    final text = left.isNegative
        ? 'closing…'
        : '${left.inMinutes}:${(left.inSeconds % 60).toString().padLeft(2, '0')}';
    return Panel(
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: G.brass),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Judging closes automatically',
              style: G.sans(size: 13.5, color: G.muted),
            ),
          ),
          Text(text, style: G.mono(size: 18, weight: FontWeight.w700)),
        ],
      ),
    );
  }
}
