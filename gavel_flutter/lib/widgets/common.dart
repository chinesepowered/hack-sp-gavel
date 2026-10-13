import 'package:flutter/material.dart';
import 'package:gavel_client/gavel_client.dart';

import '../theme.dart';

/// A bordered surface used everywhere in the app.
class Panel extends StatelessWidget {
  const Panel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color = G.ink2,
    this.borderColor = G.line,
    this.radius = 18,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color borderColor;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor),
    ),
    child: child,
  );
}

/// A softly pulsing dot for "live" indicators.
class PulseDot extends StatefulWidget {
  const PulseDot({super.key, this.color = G.signal, this.size = 9});
  final Color color;
  final double size;

  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (context, _) {
      final t = _controller.value;
      return SizedBox(
        width: widget.size * 2.4,
        height: widget.size * 2.4,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.size * (1 + 1.4 * t),
              height: widget.size * (1 + 1.4 * t),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withValues(alpha: 0.45 * (1 - t)),
              ),
            ),
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});
  final EventStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      EventStatus.setup => ('SETUP', G.sky),
      EventStatus.live => ('LIVE', G.signal),
      EventStatus.closed => ('CLOSED', G.muted),
    };
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 3, 12, 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == EventStatus.live)
            PulseDot(color: color, size: 7)
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.circle, size: 7, color: color),
            ),
          Text(
            label,
            style: G.mono(size: 11.5, weight: FontWeight.w700, color: color),
          ),
        ],
      ),
    );
  }
}

/// Big number + label.
class KpiTile extends StatelessWidget {
  const KpiTile({
    super.key,
    required this.label,
    required this.value,
    this.hint,
    this.accent = G.paper,
    this.progress,
  });

  final String label;
  final String value;
  final String? hint;
  final Color accent;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final tile = Panel(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: G.eyebrow(color: G.muted)),
          const SizedBox(height: 10),
          TweenAnimationBuilder<double>(
            tween: Tween(end: 1),
            duration: const Duration(milliseconds: 300),
            builder: (context, _, _) => Text(
              value,
              style: G.mono(size: 28, weight: FontWeight.w600, color: accent),
            ),
          ),
          const SizedBox(height: 10),
          if (progress == null)
            const SizedBox(height: 6)
          else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: progress!.clamp(0, 1)),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (context, v, _) => LinearProgressIndicator(
                  value: v,
                  minHeight: 6,
                  backgroundColor: G.ink3,
                  color: accent,
                ),
              ),
            ),
          ],
        ],
      ),
    );
    return hint == null ? tile : Tooltip(message: hint!, child: tile);
  }
}

class CenteredMessage extends StatelessWidget {
  const CenteredMessage({
    super.key,
    required this.title,
    this.body,
    this.icon,
    this.action,
  });

  final String title;
  final String? body;
  final IconData? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, size: 44, color: G.brass),
            if (icon != null) const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: G.serif(size: 30),
            ),
            if (body != null) ...[
              const SizedBox(height: 12),
              Text(
                body!,
                textAlign: TextAlign.center,
                style: G.sans(color: G.muted, size: 16, height: 1.5),
              ),
            ],
            if (action != null) ...[const SizedBox(height: 24), action!],
          ],
        ),
      ),
    ),
  );
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.label});
  final String? label;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 34,
          height: 34,
          child: CircularProgressIndicator(strokeWidth: 3, color: G.brass),
        ),
        if (label != null) ...[
          const SizedBox(height: 18),
          Text(label!, style: G.sans(color: G.muted)),
        ],
      ],
    ),
  );
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error_outline, color: G.signal, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
    ),
  );
}

void showInfo(BuildContext context, String message, {IconData? icon}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon ?? Icons.check_circle_outline, color: G.mint, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
    ),
  );
}
