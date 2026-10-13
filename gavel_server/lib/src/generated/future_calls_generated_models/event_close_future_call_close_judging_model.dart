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
import 'package:serverpod/serverpod.dart' as _is;

abstract class EventCloseFutureCallCloseJudgingModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EventCloseFutureCallCloseJudgingModel._({required this.eventId});

  factory EventCloseFutureCallCloseJudgingModel({required int eventId}) =
      _EventCloseFutureCallCloseJudgingModelImpl;

  factory EventCloseFutureCallCloseJudgingModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EventCloseFutureCallCloseJudgingModel(
      eventId: jsonSerialization['eventId'] as int,
    );
  }

  int eventId;

  /// Returns a shallow copy of this [EventCloseFutureCallCloseJudgingModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventCloseFutureCallCloseJudgingModel copyWith({int? eventId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventCloseFutureCallCloseJudgingModel',
      'eventId': eventId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _EventCloseFutureCallCloseJudgingModelImpl
    extends EventCloseFutureCallCloseJudgingModel {
  _EventCloseFutureCallCloseJudgingModelImpl({required int eventId})
    : super._(eventId: eventId);

  /// Returns a shallow copy of this [EventCloseFutureCallCloseJudgingModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventCloseFutureCallCloseJudgingModel copyWith({int? eventId}) {
    return EventCloseFutureCallCloseJudgingModel(
      eventId: eventId ?? this.eventId,
    );
  }
}
