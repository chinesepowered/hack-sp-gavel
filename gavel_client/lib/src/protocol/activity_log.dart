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
import 'activity_kind.dart' as _ig63m04h;

/// Live activity feed shown on the organizer dashboard.
abstract class ActivityLog
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ActivityLog._({
    this.id,
    required this.eventId,
    required this.kind,
    required this.message,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ActivityLog({
    int? id,
    required int eventId,
    required _ig63m04h.ActivityKind kind,
    required String message,
    DateTime? createdAt,
  }) = _ActivityLogImpl;

  factory ActivityLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityLog(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      kind: _ig63m04h.ActivityKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      message: jsonSerialization['message'] as String,
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

  _ig63m04h.ActivityKind kind;

  String message;

  DateTime createdAt;

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ActivityLog copyWith({
    int? id,
    int? eventId,
    _ig63m04h.ActivityKind? kind,
    String? message,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityLog',
      if (id != null) 'id': id,
      'eventId': eventId,
      'kind': kind.toJson(),
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityLog',
      if (id != null) 'id': id,
      'eventId': eventId,
      'kind': kind.toJson(),
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityLogImpl extends ActivityLog {
  _ActivityLogImpl({
    int? id,
    required int eventId,
    required _ig63m04h.ActivityKind kind,
    required String message,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         kind: kind,
         message: message,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ActivityLog copyWith({
    Object? id = _Undefined,
    int? eventId,
    _ig63m04h.ActivityKind? kind,
    String? message,
    DateTime? createdAt,
  }) {
    return ActivityLog(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      kind: kind ?? this.kind,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
