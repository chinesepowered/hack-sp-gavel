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

/// Additional organizers who claimed an event through its admin link.
abstract class EventOrganizer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EventOrganizer._({
    this.id,
    required this.eventId,
    required this.userId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory EventOrganizer({
    int? id,
    required int eventId,
    required _isc.UuidValue userId,
    DateTime? createdAt,
  }) = _EventOrganizerImpl;

  factory EventOrganizer.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventOrganizer(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
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

  _isc.UuidValue userId;

  DateTime createdAt;

  /// Returns a shallow copy of this [EventOrganizer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EventOrganizer copyWith({
    int? id,
    int? eventId,
    _isc.UuidValue? userId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventOrganizer',
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventOrganizer',
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventOrganizerImpl extends EventOrganizer {
  _EventOrganizerImpl({
    int? id,
    required int eventId,
    required _isc.UuidValue userId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         userId: userId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventOrganizer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EventOrganizer copyWith({
    Object? id = _Undefined,
    int? eventId,
    _isc.UuidValue? userId,
    DateTime? createdAt,
  }) {
    return EventOrganizer(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
