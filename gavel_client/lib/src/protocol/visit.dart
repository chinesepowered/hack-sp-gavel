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
import 'skip_reason.dart' as _ixl9rmv8;
import 'visit_outcome.dart' as _iici1ivk;

/// A project a judge has already been sent to (judged or skipped), so it is
/// never assigned to them again.
abstract class Visit
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Visit._({
    this.id,
    required this.eventId,
    required this.judgeId,
    required this.projectId,
    required this.outcome,
    this.skipReason,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Visit({
    int? id,
    required int eventId,
    required int judgeId,
    required int projectId,
    required _iici1ivk.VisitOutcome outcome,
    _ixl9rmv8.SkipReason? skipReason,
    DateTime? createdAt,
  }) = _VisitImpl;

  factory Visit.fromJson(Map<String, dynamic> jsonSerialization) {
    return Visit(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      judgeId: jsonSerialization['judgeId'] as int,
      projectId: jsonSerialization['projectId'] as int,
      outcome: _iici1ivk.VisitOutcome.fromJson(
        (jsonSerialization['outcome'] as String),
      ),
      skipReason: jsonSerialization['skipReason'] == null
          ? null
          : _ixl9rmv8.SkipReason.fromJson(
              (jsonSerialization['skipReason'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int eventId;

  int judgeId;

  int projectId;

  _iici1ivk.VisitOutcome outcome;

  _ixl9rmv8.SkipReason? skipReason;

  DateTime createdAt;

  /// Returns a shallow copy of this [Visit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Visit copyWith({
    int? id,
    int? eventId,
    int? judgeId,
    int? projectId,
    _iici1ivk.VisitOutcome? outcome,
    _ixl9rmv8.SkipReason? skipReason,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Visit',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'projectId': projectId,
      'outcome': outcome.toJson(),
      if (skipReason != null) 'skipReason': skipReason?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Visit',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'projectId': projectId,
      'outcome': outcome.toJson(),
      if (skipReason != null) 'skipReason': skipReason?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VisitImpl extends Visit {
  _VisitImpl({
    int? id,
    required int eventId,
    required int judgeId,
    required int projectId,
    required _iici1ivk.VisitOutcome outcome,
    _ixl9rmv8.SkipReason? skipReason,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         judgeId: judgeId,
         projectId: projectId,
         outcome: outcome,
         skipReason: skipReason,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Visit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Visit copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? judgeId,
    int? projectId,
    _iici1ivk.VisitOutcome? outcome,
    Object? skipReason = _Undefined,
    DateTime? createdAt,
  }) {
    return Visit(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      judgeId: judgeId ?? this.judgeId,
      projectId: projectId ?? this.projectId,
      outcome: outcome ?? this.outcome,
      skipReason: skipReason is _ixl9rmv8.SkipReason?
          ? skipReason
          : this.skipReason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
