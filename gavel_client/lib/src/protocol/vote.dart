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

/// One pairwise comparison: [judgeId] preferred [winnerId] over [loserId].
abstract class Vote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Vote._({
    this.id,
    required this.eventId,
    required this.judgeId,
    required this.winnerId,
    required this.loserId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Vote({
    int? id,
    required int eventId,
    required int judgeId,
    required int winnerId,
    required int loserId,
    DateTime? createdAt,
  }) = _VoteImpl;

  factory Vote.fromJson(Map<String, dynamic> jsonSerialization) {
    return Vote(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      judgeId: jsonSerialization['judgeId'] as int,
      winnerId: jsonSerialization['winnerId'] as int,
      loserId: jsonSerialization['loserId'] as int,
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

  int winnerId;

  int loserId;

  DateTime createdAt;

  /// Returns a shallow copy of this [Vote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Vote copyWith({
    int? id,
    int? eventId,
    int? judgeId,
    int? winnerId,
    int? loserId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Vote',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'winnerId': winnerId,
      'loserId': loserId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Vote',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'winnerId': winnerId,
      'loserId': loserId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VoteImpl extends Vote {
  _VoteImpl({
    int? id,
    required int eventId,
    required int judgeId,
    required int winnerId,
    required int loserId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         judgeId: judgeId,
         winnerId: winnerId,
         loserId: loserId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Vote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Vote copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? judgeId,
    int? winnerId,
    int? loserId,
    DateTime? createdAt,
  }) {
    return Vote(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      judgeId: judgeId ?? this.judgeId,
      winnerId: winnerId ?? this.winnerId,
      loserId: loserId ?? this.loserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
