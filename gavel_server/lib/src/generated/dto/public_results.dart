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
import '../dto/leaderboard_entry.dart' as _iqfcxba5;
import '../event_status.dart' as _itfhxk01;

abstract class PublicResults
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PublicResults._({
    required this.eventName,
    this.tagline,
    required this.status,
    required this.entries,
    required this.totalVotes,
    required this.judgeCount,
  });

  factory PublicResults({
    required String eventName,
    String? tagline,
    required _itfhxk01.EventStatus status,
    required List<_iqfcxba5.LeaderboardEntry> entries,
    required int totalVotes,
    required int judgeCount,
  }) = _PublicResultsImpl;

  factory PublicResults.fromJson(Map<String, dynamic> jsonSerialization) {
    return PublicResults(
      eventName: jsonSerialization['eventName'] as String,
      tagline: jsonSerialization['tagline'] as String?,
      status: _itfhxk01.EventStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      entries: _imkuj2yl.Protocol()
          .deserialize<List<_iqfcxba5.LeaderboardEntry>>(
            jsonSerialization['entries'],
          ),
      totalVotes: jsonSerialization['totalVotes'] as int,
      judgeCount: jsonSerialization['judgeCount'] as int,
    );
  }

  String eventName;

  String? tagline;

  _itfhxk01.EventStatus status;

  List<_iqfcxba5.LeaderboardEntry> entries;

  int totalVotes;

  int judgeCount;

  /// Returns a shallow copy of this [PublicResults]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PublicResults copyWith({
    String? eventName,
    String? tagline,
    _itfhxk01.EventStatus? status,
    List<_iqfcxba5.LeaderboardEntry>? entries,
    int? totalVotes,
    int? judgeCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PublicResults',
      'eventName': eventName,
      if (tagline != null) 'tagline': tagline,
      'status': status.toJson(),
      'entries': entries.toJson(valueToJson: (v) => v.toJson()),
      'totalVotes': totalVotes,
      'judgeCount': judgeCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PublicResults',
      'eventName': eventName,
      if (tagline != null) 'tagline': tagline,
      'status': status.toJson(),
      'entries': entries.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalVotes': totalVotes,
      'judgeCount': judgeCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PublicResultsImpl extends PublicResults {
  _PublicResultsImpl({
    required String eventName,
    String? tagline,
    required _itfhxk01.EventStatus status,
    required List<_iqfcxba5.LeaderboardEntry> entries,
    required int totalVotes,
    required int judgeCount,
  }) : super._(
         eventName: eventName,
         tagline: tagline,
         status: status,
         entries: entries,
         totalVotes: totalVotes,
         judgeCount: judgeCount,
       );

  /// Returns a shallow copy of this [PublicResults]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PublicResults copyWith({
    String? eventName,
    Object? tagline = _Undefined,
    _itfhxk01.EventStatus? status,
    List<_iqfcxba5.LeaderboardEntry>? entries,
    int? totalVotes,
    int? judgeCount,
  }) {
    return PublicResults(
      eventName: eventName ?? this.eventName,
      tagline: tagline is String? ? tagline : this.tagline,
      status: status ?? this.status,
      entries: entries ?? this.entries.map((e0) => e0.copyWith()).toList(),
      totalVotes: totalVotes ?? this.totalVotes,
      judgeCount: judgeCount ?? this.judgeCount,
    );
  }
}
