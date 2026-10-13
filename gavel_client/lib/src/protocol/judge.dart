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

/// A judge seat in an event. Judges authenticate with the secret token in
/// their personal magic link, so they never need an account.
abstract class Judge
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Judge._({
    this.id,
    required this.eventId,
    required this.name,
    double? alpha,
    double? beta,
    bool? active,
    this.currentProjectId,
    this.previousProjectId,
    this.assignedAt,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    DateTime? createdAt,
    this.lastActiveAt,
  }) : alpha = alpha ?? 5.0,
       beta = beta ?? 1.0,
       active = active ?? true,
       votesCast = votesCast ?? 0,
       skips = skips ?? 0,
       isSimulated = isSimulated ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Judge({
    int? id,
    required int eventId,
    required String name,
    double? alpha,
    double? beta,
    bool? active,
    int? currentProjectId,
    int? previousProjectId,
    DateTime? assignedAt,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) = _JudgeImpl;

  factory Judge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Judge(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      name: jsonSerialization['name'] as String,
      alpha: (jsonSerialization['alpha'] as num?)?.toDouble(),
      beta: (jsonSerialization['beta'] as num?)?.toDouble(),
      active: jsonSerialization['active'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
      currentProjectId: jsonSerialization['currentProjectId'] as int?,
      previousProjectId: jsonSerialization['previousProjectId'] as int?,
      assignedAt: jsonSerialization['assignedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['assignedAt'],
            ),
      votesCast: jsonSerialization['votesCast'] as int?,
      skips: jsonSerialization['skips'] as int?,
      isSimulated: jsonSerialization['isSimulated'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isSimulated']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastActiveAt: jsonSerialization['lastActiveAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastActiveAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int eventId;

  String name;

  /// Crowd-BT judge reliability prior/posterior: Beta(alpha, beta).
  double alpha;

  double beta;

  bool active;

  /// The project the judge is currently walking to / looking at.
  int? currentProjectId;

  /// The last project the judge judged (the comparison anchor).
  int? previousProjectId;

  DateTime? assignedAt;

  int votesCast;

  int skips;

  bool isSimulated;

  DateTime createdAt;

  DateTime? lastActiveAt;

  /// Returns a shallow copy of this [Judge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Judge copyWith({
    int? id,
    int? eventId,
    String? name,
    double? alpha,
    double? beta,
    bool? active,
    int? currentProjectId,
    int? previousProjectId,
    DateTime? assignedAt,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Judge',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'alpha': alpha,
      'beta': beta,
      'active': active,
      if (currentProjectId != null) 'currentProjectId': currentProjectId,
      if (previousProjectId != null) 'previousProjectId': previousProjectId,
      if (assignedAt != null) 'assignedAt': assignedAt?.toJson(),
      'votesCast': votesCast,
      'skips': skips,
      'isSimulated': isSimulated,
      'createdAt': createdAt.toJson(),
      if (lastActiveAt != null) 'lastActiveAt': lastActiveAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Judge',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'alpha': alpha,
      'beta': beta,
      'active': active,
      if (currentProjectId != null) 'currentProjectId': currentProjectId,
      if (previousProjectId != null) 'previousProjectId': previousProjectId,
      if (assignedAt != null) 'assignedAt': assignedAt?.toJson(),
      'votesCast': votesCast,
      'skips': skips,
      'isSimulated': isSimulated,
      'createdAt': createdAt.toJson(),
      if (lastActiveAt != null) 'lastActiveAt': lastActiveAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JudgeImpl extends Judge {
  _JudgeImpl({
    int? id,
    required int eventId,
    required String name,
    double? alpha,
    double? beta,
    bool? active,
    int? currentProjectId,
    int? previousProjectId,
    DateTime? assignedAt,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) : super._(
         id: id,
         eventId: eventId,
         name: name,
         alpha: alpha,
         beta: beta,
         active: active,
         currentProjectId: currentProjectId,
         previousProjectId: previousProjectId,
         assignedAt: assignedAt,
         votesCast: votesCast,
         skips: skips,
         isSimulated: isSimulated,
         createdAt: createdAt,
         lastActiveAt: lastActiveAt,
       );

  /// Returns a shallow copy of this [Judge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Judge copyWith({
    Object? id = _Undefined,
    int? eventId,
    String? name,
    double? alpha,
    double? beta,
    bool? active,
    Object? currentProjectId = _Undefined,
    Object? previousProjectId = _Undefined,
    Object? assignedAt = _Undefined,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    DateTime? createdAt,
    Object? lastActiveAt = _Undefined,
  }) {
    return Judge(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      alpha: alpha ?? this.alpha,
      beta: beta ?? this.beta,
      active: active ?? this.active,
      currentProjectId: currentProjectId is int?
          ? currentProjectId
          : this.currentProjectId,
      previousProjectId: previousProjectId is int?
          ? previousProjectId
          : this.previousProjectId,
      assignedAt: assignedAt is DateTime? ? assignedAt : this.assignedAt,
      votesCast: votesCast ?? this.votesCast,
      skips: skips ?? this.skips,
      isSimulated: isSimulated ?? this.isSimulated,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt is DateTime?
          ? lastActiveAt
          : this.lastActiveAt,
    );
  }
}
