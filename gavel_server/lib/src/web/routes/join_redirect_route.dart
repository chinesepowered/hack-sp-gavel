import 'package:serverpod/serverpod.dart';

/// Short link printed in QR codes: `/j/K7Q2XD` opens the judge app.
class JoinRedirectRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async {
    final code = (request.pathParameters.raw[#code] ?? '').toUpperCase();
    final safe = code.replaceAll(RegExp('[^A-Z0-9]'), '');
    return RedirectWidget(url: '/app/#/join/$safe');
  }
}
