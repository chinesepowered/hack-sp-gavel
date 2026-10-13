import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/live_service.dart';

/// Public, read-only results (only once an organizer publishes them).
class ResultsEndpoint extends Endpoint {
  Future<PublicResults> get(Session session, String slug) async {
    final results = await load(session, slug);
    if (results == null) {
      throw GavelException(message: 'These results are not public yet.');
    }
    return results;
  }

  static Future<PublicResults?> load(Session session, String slug) async {
    final event = await Event.db.findFirstRow(
      session,
      where: (t) => t.slug.equals(slug),
    );
    if (event == null || !event.resultsPublished) return null;
    final projects = await Project.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!),
    );
    final votes = await Vote.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!),
    );
    final judgeCount = await Judge.db.count(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.votesCast.notEquals(0),
    );
    return PublicResults(
      eventName: event.name,
      tagline: event.tagline,
      status: event.status,
      entries: LiveService.buildLeaderboard(projects, votes, activeOnly: true),
      totalVotes: votes.length,
      judgeCount: judgeCount,
    );
  }
}
