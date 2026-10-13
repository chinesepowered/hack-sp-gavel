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
import '../event.dart' as _i5sgn0cc;

/// Everything an organizer needs to run an event.
abstract class OrganizerEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OrganizerEvent._({
    required this.event,
    required this.adminKey,
    required this.isOwner,
  });

  factory OrganizerEvent({
    required _i5sgn0cc.Event event,
    required String adminKey,
    required bool isOwner,
  }) = _OrganizerEventImpl;

  factory OrganizerEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrganizerEvent(
      event: _imkuj2yl.Protocol().deserialize<_i5sgn0cc.Event>(
        jsonSerialization['event'],
      ),
      adminKey: jsonSerialization['adminKey'] as String,
      isOwner: _is.BoolJsonExtension.fromJson(jsonSerialization['isOwner']),
    );
  }

  _i5sgn0cc.Event event;

  String adminKey;

  bool isOwner;

  /// Returns a shallow copy of this [OrganizerEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OrganizerEvent copyWith({
    _i5sgn0cc.Event? event,
    String? adminKey,
    bool? isOwner,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrganizerEvent',
      'event': event.toJson(),
      'adminKey': adminKey,
      'isOwner': isOwner,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrganizerEvent',
      'event': event.toJsonForProtocol(),
      'adminKey': adminKey,
      'isOwner': isOwner,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OrganizerEventImpl extends OrganizerEvent {
  _OrganizerEventImpl({
    required _i5sgn0cc.Event event,
    required String adminKey,
    required bool isOwner,
  }) : super._(
         event: event,
         adminKey: adminKey,
         isOwner: isOwner,
       );

  /// Returns a shallow copy of this [OrganizerEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OrganizerEvent copyWith({
    _i5sgn0cc.Event? event,
    String? adminKey,
    bool? isOwner,
  }) {
    return OrganizerEvent(
      event: event ?? this.event.copyWith(),
      adminKey: adminKey ?? this.adminKey,
      isOwner: isOwner ?? this.isOwner,
    );
  }
}
