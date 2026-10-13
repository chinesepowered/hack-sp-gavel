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

/// A project's posterior after a vote, for the convergence chart.
abstract class ScoreSnapshot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ScoreSnapshot._({
    this.id,
    required this.eventId,
    required this.projectId,
    required this.mu,
    required this.sigmaSq,
    required this.voteNumber,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ScoreSnapshot({
    int? id,
    required int eventId,
    required int projectId,
    required double mu,
    required double sigmaSq,
    required int voteNumber,
    DateTime? createdAt,
  }) = _ScoreSnapshotImpl;

  factory ScoreSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScoreSnapshot(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      projectId: jsonSerialization['projectId'] as int,
      mu: (jsonSerialization['mu'] as num).toDouble(),
      sigmaSq: (jsonSerialization['sigmaSq'] as num).toDouble(),
      voteNumber: jsonSerialization['voteNumber'] as int,
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

  int projectId;

  double mu;

  double sigmaSq;

  /// Total number of votes in the event when the snapshot was taken.
  int voteNumber;

  DateTime createdAt;

  /// Returns a shallow copy of this [ScoreSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ScoreSnapshot copyWith({
    int? id,
    int? eventId,
    int? projectId,
    double? mu,
    double? sigmaSq,
    int? voteNumber,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScoreSnapshot',
      if (id != null) 'id': id,
      'eventId': eventId,
      'projectId': projectId,
      'mu': mu,
      'sigmaSq': sigmaSq,
      'voteNumber': voteNumber,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScoreSnapshot',
      if (id != null) 'id': id,
      'eventId': eventId,
      'projectId': projectId,
      'mu': mu,
      'sigmaSq': sigmaSq,
      'voteNumber': voteNumber,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScoreSnapshotImpl extends ScoreSnapshot {
  _ScoreSnapshotImpl({
    int? id,
    required int eventId,
    required int projectId,
    required double mu,
    required double sigmaSq,
    required int voteNumber,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         projectId: projectId,
         mu: mu,
         sigmaSq: sigmaSq,
         voteNumber: voteNumber,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ScoreSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ScoreSnapshot copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? projectId,
    double? mu,
    double? sigmaSq,
    int? voteNumber,
    DateTime? createdAt,
  }) {
    return ScoreSnapshot(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      projectId: projectId ?? this.projectId,
      mu: mu ?? this.mu,
      sigmaSq: sigmaSq ?? this.sigmaSq,
      voteNumber: voteNumber ?? this.voteNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
