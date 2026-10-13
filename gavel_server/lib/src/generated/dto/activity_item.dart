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
import '../activity_kind.dart' as _ij7snvcq;

abstract class ActivityItem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ActivityItem._({
    required this.kind,
    required this.message,
    required this.at,
  });

  factory ActivityItem({
    required _ij7snvcq.ActivityKind kind,
    required String message,
    required DateTime at,
  }) = _ActivityItemImpl;

  factory ActivityItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityItem(
      kind: _ij7snvcq.ActivityKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      message: jsonSerialization['message'] as String,
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  _ij7snvcq.ActivityKind kind;

  String message;

  DateTime at;

  /// Returns a shallow copy of this [ActivityItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ActivityItem copyWith({
    _ij7snvcq.ActivityKind? kind,
    String? message,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityItem',
      'kind': kind.toJson(),
      'message': message,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityItem',
      'kind': kind.toJson(),
      'message': message,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ActivityItemImpl extends ActivityItem {
  _ActivityItemImpl({
    required _ij7snvcq.ActivityKind kind,
    required String message,
    required DateTime at,
  }) : super._(
         kind: kind,
         message: message,
         at: at,
       );

  /// Returns a shallow copy of this [ActivityItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ActivityItem copyWith({
    _ij7snvcq.ActivityKind? kind,
    String? message,
    DateTime? at,
  }) {
    return ActivityItem(
      kind: kind ?? this.kind,
      message: message ?? this.message,
      at: at ?? this.at,
    );
  }
}
