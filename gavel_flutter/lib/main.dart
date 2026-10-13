import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'client.dart';
import 'router.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const GavelApp());
  // `?semantics` turns on the accessibility tree from the first frame
  // (handy for screen readers and for browser automation).
  if (kIsWeb && Uri.base.queryParameters.containsKey('semantics')) {
    SemanticsBinding.instance.ensureSemantics();
  }
}

class GavelApp extends StatelessWidget {
  const GavelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gavel',
      debugShowCheckedModeBanner: false,
      theme: G.theme(),
      routerConfig: router,
    );
  }
}
