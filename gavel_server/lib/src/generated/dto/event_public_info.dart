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
import '../event_status.dart' as _itfhxk01;

/// Public info shown on the judge join screen.
abstract class EventPublicInfo
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EventPublicInfo._({
    required this.name,
    this.tagline,
    required this.status,
    required this.projectCount,
    required this.judgeCount,
  });

  factory EventPublicInfo({
    required String name,
    String? tagline,
    required _itfhxk01.EventStatus status,
    required int projectCount,
    required int judgeCount,
  }) = _EventPublicInfoImpl;

  factory EventPublicInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventPublicInfo(
      name: jsonSerialization['name'] as String,
      tagline: jsonSerialization['tagline'] as String?,
      status: _itfhxk01.EventStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      projectCount: jsonSerialization['projectCount'] as int,
      judgeCount: jsonSerialization['judgeCount'] as int,
    );
  }

  String name;

  String? tagline;

  _itfhxk01.EventStatus status;

  int projectCount;

  int judgeCount;

  /// Returns a shallow copy of this [EventPublicInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventPublicInfo copyWith({
    String? name,
    String? tagline,
    _itfhxk01.EventStatus? status,
    int? projectCount,
    int? judgeCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventPublicInfo',
      'name': name,
      if (tagline != null) 'tagline': tagline,
      'status': status.toJson(),
      'projectCount': projectCount,
      'judgeCount': judgeCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventPublicInfo',
      'name': name,
      if (tagline != null) 'tagline': tagline,
      'status': status.toJson(),
      'projectCount': projectCount,
      'judgeCount': judgeCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventPublicInfoImpl extends EventPublicInfo {
  _EventPublicInfoImpl({
    required String name,
    String? tagline,
    required _itfhxk01.EventStatus status,
    required int projectCount,
    required int judgeCount,
  }) : super._(
         name: name,
         tagline: tagline,
         status: status,
         projectCount: projectCount,
         judgeCount: judgeCount,
       );

  /// Returns a shallow copy of this [EventPublicInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventPublicInfo copyWith({
    String? name,
    Object? tagline = _Undefined,
    _itfhxk01.EventStatus? status,
    int? projectCount,
    int? judgeCount,
  }) {
    return EventPublicInfo(
      name: name ?? this.name,
      tagline: tagline is String? ? tagline : this.tagline,
      status: status ?? this.status,
      projectCount: projectCount ?? this.projectCount,
      judgeCount: judgeCount ?? this.judgeCount,
    );
  }
}
