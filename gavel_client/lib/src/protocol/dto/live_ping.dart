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

/// Server event posted whenever something changes in an event.
abstract class LivePing
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LivePing._({required this.eventId});

  factory LivePing({required int eventId}) = _LivePingImpl;

  factory LivePing.fromJson(Map<String, dynamic> jsonSerialization) {
    return LivePing(eventId: jsonSerialization['eventId'] as int);
  }

  int eventId;

  /// Returns a shallow copy of this [LivePing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LivePing copyWith({int? eventId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LivePing',
      'eventId': eventId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LivePing',
      'eventId': eventId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LivePingImpl extends LivePing {
  _LivePingImpl({required int eventId}) : super._(eventId: eventId);

  /// Returns a shallow copy of this [LivePing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LivePing copyWith({int? eventId}) {
    return LivePing(eventId: eventId ?? this.eventId);
  }
}
