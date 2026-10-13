import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gavel_client/gavel_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// The server URL comes from --dart-define=SERVER_URL=..., or from
// assets/config.json (served dynamically by the Serverpod web server in
// production), or defaults to http://localhost:8080/.
final serverUrl = getServerUrl();

/// Global client used across the app.
late final Client client;

Future<void> initializeClient() async {
  client = Client(await serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();
}

/// Signs in with an anonymous account if nobody is signed in yet, so an
/// organizer can try Gavel without any form.
Future<void> ensureSignedIn() async {
  if (client.auth.isAuthenticated) return;
  final success = await client.anonymousIdp.login(token: null);
  await client.auth.updateSignedInUser(success);
}

/// Origin of the public web server (where the app and short links live).
String webOrigin() {
  if (kIsWeb) return Uri.base.origin;
  return 'http://localhost:8082';
}

String joinUrl(String code) => '${webOrigin()}/j/$code';
String judgeUrl(String token) => '${webOrigin()}/app/#/judge/$token';
String resultsUrl(String slug) => '${webOrigin()}/results/$slug';

/// Human readable message for any error thrown by the client.
String friendlyError(Object error) {
  if (error is GavelException) return error.message;
  if (error is ServerpodClientException) {
    return 'The server could not complete that request.';
  }
  if (error is TimeoutException) return 'The server took too long to answer.';
  return 'Something went wrong. Check your connection and try again.';
}
