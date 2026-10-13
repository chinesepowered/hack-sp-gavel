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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class LeaderboardEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LeaderboardEntry._({
    required this.projectId,
    required this.rank,
    required this.name,
    required this.location,
    this.team,
    required this.mu,
    required this.sigma,
    required this.timesSeen,
    required this.active,
    required this.prioritized,
    required this.absentReports,
    required this.podiumProbability,
    required this.wins,
    required this.losses,
  });

  factory LeaderboardEntry({
    required int projectId,
    required int rank,
    required String name,
    required String location,
    String? team,
    required double mu,
    required double sigma,
    required int timesSeen,
    required bool active,
    required bool prioritized,
    required int absentReports,
    required double podiumProbability,
    required int wins,
    required int losses,
  }) = _LeaderboardEntryImpl;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaderboardEntry(
      projectId: jsonSerialization['projectId'] as int,
      rank: jsonSerialization['rank'] as int,
      name: jsonSerialization['name'] as String,
      location: jsonSerialization['location'] as String,
      team: jsonSerialization['team'] as String?,
      mu: (jsonSerialization['mu'] as num).toDouble(),
      sigma: (jsonSerialization['sigma'] as num).toDouble(),
      timesSeen: jsonSerialization['timesSeen'] as int,
      active: _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
      prioritized: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['prioritized'],
      ),
      absentReports: jsonSerialization['absentReports'] as int,
      podiumProbability: (jsonSerialization['podiumProbability'] as num)
          .toDouble(),
      wins: jsonSerialization['wins'] as int,
      losses: jsonSerialization['losses'] as int,
    );
  }

  int projectId;

  int rank;

  String name;

  String location;

  String? team;

  double mu;

  double sigma;

  int timesSeen;

  bool active;

  bool prioritized;

  int absentReports;

  /// Monte Carlo estimate of the probability this project truly belongs on
  /// the podium (top 3), given the current posteriors.
  double podiumProbability;

  int wins;

  int losses;

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LeaderboardEntry copyWith({
    int? projectId,
    int? rank,
    String? name,
    String? location,
    String? team,
    double? mu,
    double? sigma,
    int? timesSeen,
    bool? active,
    bool? prioritized,
    int? absentReports,
    double? podiumProbability,
    int? wins,
    int? losses,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaderboardEntry',
      'projectId': projectId,
      'rank': rank,
      'name': name,
      'location': location,
      if (team != null) 'team': team,
      'mu': mu,
      'sigma': sigma,
      'timesSeen': timesSeen,
      'active': active,
      'prioritized': prioritized,
      'absentReports': absentReports,
      'podiumProbability': podiumProbability,
      'wins': wins,
      'losses': losses,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeaderboardEntry',
      'projectId': projectId,
      'rank': rank,
      'name': name,
      'location': location,
      if (team != null) 'team': team,
      'mu': mu,
      'sigma': sigma,
      'timesSeen': timesSeen,
      'active': active,
      'prioritized': prioritized,
      'absentReports': absentReports,
      'podiumProbability': podiumProbability,
      'wins': wins,
      'losses': losses,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeaderboardEntryImpl extends LeaderboardEntry {
  _LeaderboardEntryImpl({
    required int projectId,
    required int rank,
    required String name,
    required String location,
    String? team,
    required double mu,
    required double sigma,
    required int timesSeen,
    required bool active,
    required bool prioritized,
    required int absentReports,
    required double podiumProbability,
    required int wins,
    required int losses,
  }) : super._(
         projectId: projectId,
         rank: rank,
         name: name,
         location: location,
         team: team,
         mu: mu,
         sigma: sigma,
         timesSeen: timesSeen,
         active: active,
         prioritized: prioritized,
         absentReports: absentReports,
         podiumProbability: podiumProbability,
         wins: wins,
         losses: losses,
       );

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LeaderboardEntry copyWith({
    int? projectId,
    int? rank,
    String? name,
    String? location,
    Object? team = _Undefined,
    double? mu,
    double? sigma,
    int? timesSeen,
    bool? active,
    bool? prioritized,
    int? absentReports,
    double? podiumProbability,
    int? wins,
    int? losses,
  }) {
    return LeaderboardEntry(
      projectId: projectId ?? this.projectId,
      rank: rank ?? this.rank,
      name: name ?? this.name,
      location: location ?? this.location,
      team: team is String? ? team : this.team,
      mu: mu ?? this.mu,
      sigma: sigma ?? this.sigma,
      timesSeen: timesSeen ?? this.timesSeen,
      active: active ?? this.active,
      prioritized: prioritized ?? this.prioritized,
      absentReports: absentReports ?? this.absentReports,
      podiumProbability: podiumProbability ?? this.podiumProbability,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
    );
  }
}
