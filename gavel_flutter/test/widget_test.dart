import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gavel_flutter/widgets/gavel_logo.dart';

void main() {
  testWidgets('Given the wordmark when rendered then it shows the name', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: GavelLogo())),
      ),
    );
    expect(find.byType(GavelLogo), findsOneWidget);
  });
}
