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

/// Cached numbers for the landing page.
abstract class LandingStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LandingStats._({
    required this.events,
    required this.projects,
    required this.votes,
  });

  factory LandingStats({
    required int events,
    required int projects,
    required int votes,
  }) = _LandingStatsImpl;

  factory LandingStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return LandingStats(
      events: jsonSerialization['events'] as int,
      projects: jsonSerialization['projects'] as int,
      votes: jsonSerialization['votes'] as int,
    );
  }

  int events;

  int projects;

  int votes;

  /// Returns a shallow copy of this [LandingStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LandingStats copyWith({
    int? events,
    int? projects,
    int? votes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LandingStats',
      'events': events,
      'projects': projects,
      'votes': votes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LandingStats',
      'events': events,
      'projects': projects,
      'votes': votes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LandingStatsImpl extends LandingStats {
  _LandingStatsImpl({
    required int events,
    required int projects,
    required int votes,
  }) : super._(
         events: events,
         projects: projects,
         votes: votes,
       );

  /// Returns a shallow copy of this [LandingStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LandingStats copyWith({
    int? events,
    int? projects,
    int? votes,
  }) {
    return LandingStats(
      events: events ?? this.events,
      projects: projects ?? this.projects,
      votes: votes ?? this.votes,
    );
  }
}
