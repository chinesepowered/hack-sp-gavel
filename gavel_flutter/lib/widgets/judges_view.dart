import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gavel_client/gavel_client.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../client.dart';
import '../theme.dart';
import 'common.dart';

/// Judges on the floor, with how much Crowd-BT trusts each of them.
class JudgesView extends StatelessWidget {
  const JudgesView({super.key, required this.eventId, required this.judges});

  final int eventId;
  final List<JudgeSummary> judges;

  Future<void> _addJudge(BuildContext context) async {
    final name = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invite a judge', style: G.serif(size: 24)),
        content: SizedBox(
          width: 380,
          child: TextField(
            controller: name,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Judge name'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Create magic link'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    try {
      final token = await client.organizer.addJudge(eventId, name.text);
      if (context.mounted) await _showLink(context, name.text, token);
    } catch (e) {
      if (context.mounted) showError(context, friendlyError(e));
    }
  }

  Future<void> _showLink(BuildContext context, String name, String token) {
    final url = judgeUrl(token);
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Magic link for $name', style: G.serif(size: 24)),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: G.paper,
                child: QrImageView(data: url, size: 200),
              ),
              const SizedBox(height: 14),
              SelectableText(url, style: G.mono(size: 12, color: G.muted)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: url));
              Navigator.pop(context);
            },
            child: const Text('Copy & close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Outliers first, then the busiest judges.
    final sorted = [...judges]
      ..sort((a, b) {
        final fa = _isOutlier(a) ? 0 : 1;
        final fb = _isOutlier(b) ? 0 : 1;
        if (fa != fb) return fa.compareTo(fb);
        return b.votesCast.compareTo(a.votesCast);
      });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Reliability is learned from votes: judges who keep '
                'disagreeing with the consensus automatically count for less.',
                style: G.sans(color: G.muted, size: 13.5, height: 1.4),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () => _addJudge(context),
              icon: const Icon(Icons.person_add_alt_rounded, size: 18),
              label: const Text('Invite judge'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (sorted.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'No judges yet. Share the QR code, or invite judges with a '
              'personal magic link.',
              style: G.sans(color: G.muted),
            ),
          ),
        for (final judge in sorted) _JudgeRow(judge: judge),
      ],
    );
  }
}

/// Agreement is measured against a ranking fitted on everyone else's votes.
bool _isOutlier(JudgeSummary judge) =>
    judge.votesCast >= 5 && judge.agreement < 0.4;

class _JudgeRow extends StatelessWidget {
  const _JudgeRow({required this.judge});
  final JudgeSummary judge;

  @override
  Widget build(BuildContext context) {
    final flagged = _isOutlier(judge);
    final reliabilityColor = judge.reliability >= 0.8
        ? G.mint
        : judge.reliability >= 0.7
        ? G.brass
        : G.signal;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: flagged ? G.signal.withValues(alpha: 0.07) : G.ink2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: flagged ? G.signal.withValues(alpha: 0.4) : G.line,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: judge.isSimulated ? G.ink3 : G.brass,
            child: judge.isSimulated
                ? const Icon(Icons.smart_toy_outlined, size: 18, color: G.sky)
                : Text(
                    judge.name.isEmpty ? '?' : judge.name[0].toUpperCase(),
                    style: G.sans(weight: FontWeight.w800, color: G.ink),
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        judge.name,
                        overflow: TextOverflow.ellipsis,
                        style: G.sans(size: 15, weight: FontWeight.w800),
                      ),
                    ),
                    if (flagged) ...[
                      const SizedBox(width: 8),
                      Tooltip(
                        message:
                            'Most of this judge’s votes go against the '
                            'consensus. Crowd-BT has already reduced their '
                            'weight.',
                        child: Text(
                          'OUTLIER',
                          style: G.eyebrow(color: G.signal),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  judge.currentLocation == null
                      ? (judge.active ? 'Between tables' : 'Paused')
                      : 'At ${judge.currentLocation} · ${judge.currentProjectName}',
                  overflow: TextOverflow.ellipsis,
                  style: G.sans(size: 12.5, color: G.muted),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Reliability ',
                      style: G.sans(size: 11.5, color: G.faint),
                    ),
                    Text(
                      '${(judge.reliability * 100).round()}%',
                      style: G.mono(
                        size: 12.5,
                        weight: FontWeight.w700,
                        color: reliabilityColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(end: judge.reliability),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, v, _) => LinearProgressIndicator(
                      value: v,
                      minHeight: 5,
                      backgroundColor: G.ink3,
                      color: reliabilityColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          SizedBox(
            width: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${(judge.agreement * 100).round()}%',
                  style: G.mono(
                    size: 14,
                    weight: FontWeight.w700,
                    color: flagged ? G.signal : G.paper,
                  ),
                ),
                Text(
                  'agree w/ others',
                  style: G.sans(size: 11, color: G.faint),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${judge.votesCast}', style: G.mono(size: 14)),
                Text('votes', style: G.sans(size: 11, color: G.faint)),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Switch(
            value: judge.active,
            onChanged: (v) async {
              try {
                await client.organizer.setJudgeActive(judge.id, v);
              } catch (e) {
                if (context.mounted) showError(context, friendlyError(e));
              }
            },
          ),
        ],
      ),
    );
  }
}
