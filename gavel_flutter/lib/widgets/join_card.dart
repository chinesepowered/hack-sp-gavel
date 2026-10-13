import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../client.dart';
import '../theme.dart';
import 'common.dart';

/// The QR code judges scan to join, plus the typed code.
class JoinCard extends StatelessWidget {
  const JoinCard({super.key, required this.code, this.big = false});
  final String code;
  final bool big;

  @override
  Widget build(BuildContext context) {
    final url = joinUrl(code);
    return Panel(
      padding: EdgeInsets.all(big ? 28 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('JUDGES: SCAN TO JOIN', style: G.eyebrow()),
          const SizedBox(height: 14),
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: G.paper,
                borderRadius: BorderRadius.circular(14),
              ),
              child: QrImageView(
                data: url,
                size: big ? 240 : 168,
                backgroundColor: G.paper,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: G.ink,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: G.ink,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              code,
              style: G.mono(
                size: big ? 40 : 30,
                weight: FontWeight.w700,
                color: G.brass,
                spacing: 4,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              url.replaceFirst(RegExp('^https?://'), ''),
              style: G.mono(size: big ? 15 : 12, color: G.muted),
            ),
          ),
          if (!big) ...[
            const SizedBox(height: 10),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: url));
                  showInfo(context, 'Judge link copied');
                },
                icon: const Icon(Icons.copy_rounded, size: 16),
                label: const Text('Copy link'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
