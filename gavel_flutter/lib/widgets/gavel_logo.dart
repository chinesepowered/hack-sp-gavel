import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';

/// The Gavel mark: a brass gavel over its sound block.
class GavelLogo extends StatelessWidget {
  const GavelLogo({super.key, this.size = 40});
  final double size;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size.square(size), painter: _GavelPainter());
}

class _GavelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 64;
    canvas.scale(s);
    final bg = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 0, 64, 64),
      const Radius.circular(14),
    );
    canvas.drawRRect(bg, Paint()..color = G.ink2);
    canvas.drawRRect(
      bg.deflate(0.5),
      Paint()
        ..color = G.line
        ..style = PaintingStyle.stroke,
    );

    canvas.save();
    canvas.translate(32, 30);
    canvas.rotate(-38 * math.pi / 180);
    canvas.translate(-32, -30);
    final brass = Paint()..color = G.brass;
    final brassDark = Paint()..color = G.brass2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(19, 13, 26, 12),
        const Radius.circular(3.5),
      ),
      brass,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(16, 14.5, 4, 9),
        const Radius.circular(1.5),
      ),
      brassDark,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(44, 14.5, 4, 9),
        const Radius.circular(1.5),
      ),
      brassDark,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(29.6, 24, 4.8, 24),
        const Radius.circular(2.4),
      ),
      Paint()..color = G.paper,
    );
    canvas.restore();
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(14, 48, 30, 6),
        const Radius.circular(2),
      ),
      Paint()..color = G.brass.withValues(alpha: 0.85),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Logo + wordmark.
class GavelWordmark extends StatelessWidget {
  const GavelWordmark({super.key, this.size = 34});
  final double size;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      GavelLogo(size: size),
      SizedBox(width: size * 0.32),
      Text(
        'Gavel',
        style: G.serif(size: size * 0.72, weight: FontWeight.w700),
      ),
    ],
  );
}
