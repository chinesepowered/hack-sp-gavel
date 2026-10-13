/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gavel_server/src/generated/protocol.dart' as _imkuj2yl;
import 'package:serverpod/serverpod.dart' as _is;
import '../dto/activity_item.dart' as _iw5fo09q;
import '../dto/judge_summary.dart' as _irhvdi5z;
import '../dto/leaderboard_entry.dart' as _iqfcxba5;
import '../event_status.dart' as _itfhxk01;

/// Full live state of an event, streamed to organizer dashboards.
abstract class LiveSnapshot
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LiveSnapshot._({
    required this.eventId,
    required this.status,
    required this.simulationRunning,
    required this.resultsPublished,
    required this.leaderboard,
    required this.judges,
    required this.activity,
    required this.totalVotes,
    required this.activeJudges,
    required this.podiumCertainty,
    required this.averageViews,
    required this.coverage,
    this.closesAt,
    required this.serverTime,
  });

  factory LiveSnapshot({
    required int eventId,
    required _itfhxk01.EventStatus status,
    required bool simulationRunning,
    required bool resultsPublished,
    required List<_iqfcxba5.LeaderboardEntry> leaderboard,
    required List<_irhvdi5z.JudgeSummary> judges,
    required List<_iw5fo09q.ActivityItem> activity,
    required int totalVotes,
    required int activeJudges,
    required double podiumCertainty,
    required double averageViews,
    required double coverage,
    DateTime? closesAt,
    required DateTime serverTime,
  }) = _LiveSnapshotImpl;

  factory LiveSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return LiveSnapshot(
      eventId: jsonSerialization['eventId'] as int,
      status: _itfhxk01.EventStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      simulationRunning: _is.BoolJsonExtension.fromJson(
        jsonSerialization['simulationRunning'],
      ),
      resultsPublished: _is.BoolJsonExtension.fromJson(
        jsonSerialization['resultsPublished'],
      ),
      leaderboard: _imkuj2yl.Protocol()
          .deserialize<List<_iqfcxba5.LeaderboardEntry>>(
            jsonSerialization['leaderboard'],
          ),
      judges: _imkuj2yl.Protocol().deserialize<List<_irhvdi5z.JudgeSummary>>(
        jsonSerialization['judges'],
      ),
      activity: _imkuj2yl.Protocol().deserialize<List<_iw5fo09q.ActivityItem>>(
        jsonSerialization['activity'],
      ),
      totalVotes: jsonSerialization['totalVotes'] as int,
      activeJudges: jsonSerialization['activeJudges'] as int,
      podiumCertainty: (jsonSerialization['podiumCertainty'] as num).toDouble(),
      averageViews: (jsonSerialization['averageViews'] as num).toDouble(),
      coverage: (jsonSerialization['coverage'] as num).toDouble(),
      closesAt: jsonSerialization['closesAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['closesAt']),
      serverTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverTime'],
      ),
    );
  }

  int eventId;

  _itfhxk01.EventStatus status;

  bool simulationRunning;

  bool resultsPublished;

  List<_iqfcxba5.LeaderboardEntry> leaderboard;

  List<_irhvdi5z.JudgeSummary> judges;

  List<_iw5fo09q.ActivityItem> activity;

  int totalVotes;

  int activeJudges;

  /// Probability the current top 3 is the true top 3 (Monte Carlo).
  double podiumCertainty;

  /// Average number of views per active project.
  double averageViews;

  /// Fraction of active projects that reached the minimum number of views.
  double coverage;

  DateTime? closesAt;

  DateTime serverTime;

  /// Returns a shallow copy of this [LiveSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LiveSnapshot copyWith({
    int? eventId,
    _itfhxk01.EventStatus? status,
    bool? simulationRunning,
    bool? resultsPublished,
    List<_iqfcxba5.LeaderboardEntry>? leaderboard,
    List<_irhvdi5z.JudgeSummary>? judges,
    List<_iw5fo09q.ActivityItem>? activity,
    int? totalVotes,
    int? activeJudges,
    double? podiumCertainty,
    double? averageViews,
    double? coverage,
    DateTime? closesAt,
    DateTime? serverTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LiveSnapshot',
      'eventId': eventId,
      'status': status.toJson(),
      'simulationRunning': simulationRunning,
      'resultsPublished': resultsPublished,
      'leaderboard': leaderboard.toJson(valueToJson: (v) => v.toJson()),
      'judges': judges.toJson(valueToJson: (v) => v.toJson()),
      'activity': activity.toJson(valueToJson: (v) => v.toJson()),
      'totalVotes': totalVotes,
      'activeJudges': activeJudges,
      'podiumCertainty': podiumCertainty,
      'averageViews': averageViews,
      'coverage': coverage,
      if (closesAt != null) 'closesAt': closesAt?.toJson(),
      'serverTime': serverTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LiveSnapshot',
      'eventId': eventId,
      'status': status.toJson(),
      'simulationRunning': simulationRunning,
      'resultsPublished': resultsPublished,
      'leaderboard': leaderboard.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'judges': judges.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'activity': activity.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalVotes': totalVotes,
      'activeJudges': activeJudges,
      'podiumCertainty': podiumCertainty,
      'averageViews': averageViews,
      'coverage': coverage,
      if (closesAt != null) 'closesAt': closesAt?.toJson(),
      'serverTime': serverTime.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LiveSnapshotImpl extends LiveSnapshot {
  _LiveSnapshotImpl({
    required int eventId,
    required _itfhxk01.EventStatus status,
    required bool simulationRunning,
    required bool resultsPublished,
    required List<_iqfcxba5.LeaderboardEntry> leaderboard,
    required List<_irhvdi5z.JudgeSummary> judges,
    required List<_iw5fo09q.ActivityItem> activity,
    required int totalVotes,
    required int activeJudges,
    required double podiumCertainty,
    required double averageViews,
    required double coverage,
    DateTime? closesAt,
    required DateTime serverTime,
  }) : super._(
         eventId: eventId,
         status: status,
         simulationRunning: simulationRunning,
         resultsPublished: resultsPublished,
         leaderboard: leaderboard,
         judges: judges,
         activity: activity,
         totalVotes: totalVotes,
         activeJudges: activeJudges,
         podiumCertainty: podiumCertainty,
         averageViews: averageViews,
         coverage: coverage,
         closesAt: closesAt,
         serverTime: serverTime,
       );

  /// Returns a shallow copy of this [LiveSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LiveSnapshot copyWith({
    int? eventId,
    _itfhxk01.EventStatus? status,
    bool? simulationRunning,
    bool? resultsPublished,
    List<_iqfcxba5.LeaderboardEntry>? leaderboard,
    List<_irhvdi5z.JudgeSummary>? judges,
    List<_iw5fo09q.ActivityItem>? activity,
    int? totalVotes,
    int? activeJudges,
    double? podiumCertainty,
    double? averageViews,
    double? coverage,
    Object? closesAt = _Undefined,
    DateTime? serverTime,
  }) {
    return LiveSnapshot(
      eventId: eventId ?? this.eventId,
      status: status ?? this.status,
      simulationRunning: simulationRunning ?? this.simulationRunning,
      resultsPublished: resultsPublished ?? this.resultsPublished,
      leaderboard:
          leaderboard ?? this.leaderboard.map((e0) => e0.copyWith()).toList(),
      judges: judges ?? this.judges.map((e0) => e0.copyWith()).toList(),
      activity: activity ?? this.activity.map((e0) => e0.copyWith()).toList(),
      totalVotes: totalVotes ?? this.totalVotes,
      activeJudges: activeJudges ?? this.activeJudges,
      podiumCertainty: podiumCertainty ?? this.podiumCertainty,
      averageViews: averageViews ?? this.averageViews,
      coverage: coverage ?? this.coverage,
      closesAt: closesAt is DateTime? ? closesAt : this.closesAt,
      serverTime: serverTime ?? this.serverTime,
    );
  }
}
