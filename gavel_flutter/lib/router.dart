import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/judge/join_screen.dart';
import 'screens/judge/judge_screen.dart';
import 'screens/organizer/claim_screen.dart';
import 'screens/organizer/dashboard_screen.dart';
import 'screens/organizer/demo_screen.dart';
import 'screens/organizer/events_screen.dart';
import 'screens/organizer/organizer_gate.dart';
import 'screens/organizer/present_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/demo', builder: (context, state) => const DemoScreen()),
    GoRoute(path: '/join', builder: (context, state) => const JoinScreen()),
    GoRoute(
      path: '/join/:code',
      builder: (context, state) =>
          JoinScreen(code: state.pathParameters['code']),
    ),
    GoRoute(
      path: '/judge/:token',
      builder: (context, state) =>
          JudgeScreen(token: state.pathParameters['token']!),
    ),
    GoRoute(
      path: '/events',
      builder: (context, state) => const OrganizerGate(child: EventsScreen()),
    ),
    GoRoute(
      path: '/events/:id',
      builder: (context, state) => OrganizerGate(
        child: DashboardScreen(
          eventId: int.parse(state.pathParameters['id']!),
          tour: state.uri.queryParameters['tour'] == '1',
        ),
      ),
    ),
    GoRoute(
      path: '/events/:id/present',
      builder: (context, state) => OrganizerGate(
        child: PresentScreen(eventId: int.parse(state.pathParameters['id']!)),
      ),
    ),
    GoRoute(
      path: '/claim/:key',
      builder: (context, state) => OrganizerGate(
        child: ClaimScreen(adminKey: state.pathParameters['key']!),
      ),
    ),
  ],
);
