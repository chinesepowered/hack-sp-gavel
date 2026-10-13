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

/// Compact event info for the organizer's event list.
abstract class EventSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EventSummary._({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.isDemo,
    required this.projectCount,
    required this.judgeCount,
    required this.voteCount,
    required this.createdAt,
  });

  factory EventSummary({
    required int id,
    required String name,
    required String slug,
    required _itfhxk01.EventStatus status,
    required bool isDemo,
    required int projectCount,
    required int judgeCount,
    required int voteCount,
    required DateTime createdAt,
  }) = _EventSummaryImpl;

  factory EventSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventSummary(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      status: _itfhxk01.EventStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      isDemo: _is.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      projectCount: jsonSerialization['projectCount'] as int,
      judgeCount: jsonSerialization['judgeCount'] as int,
      voteCount: jsonSerialization['voteCount'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  int id;

  String name;

  String slug;

  _itfhxk01.EventStatus status;

  bool isDemo;

  int projectCount;

  int judgeCount;

  int voteCount;

  DateTime createdAt;

  /// Returns a shallow copy of this [EventSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventSummary copyWith({
    int? id,
    String? name,
    String? slug,
    _itfhxk01.EventStatus? status,
    bool? isDemo,
    int? projectCount,
    int? judgeCount,
    int? voteCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventSummary',
      'id': id,
      'name': name,
      'slug': slug,
      'status': status.toJson(),
      'isDemo': isDemo,
      'projectCount': projectCount,
      'judgeCount': judgeCount,
      'voteCount': voteCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventSummary',
      'id': id,
      'name': name,
      'slug': slug,
      'status': status.toJson(),
      'isDemo': isDemo,
      'projectCount': projectCount,
      'judgeCount': judgeCount,
      'voteCount': voteCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _EventSummaryImpl extends EventSummary {
  _EventSummaryImpl({
    required int id,
    required String name,
    required String slug,
    required _itfhxk01.EventStatus status,
    required bool isDemo,
    required int projectCount,
    required int judgeCount,
    required int voteCount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         slug: slug,
         status: status,
         isDemo: isDemo,
         projectCount: projectCount,
         judgeCount: judgeCount,
         voteCount: voteCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventSummary copyWith({
    int? id,
    String? name,
    String? slug,
    _itfhxk01.EventStatus? status,
    bool? isDemo,
    int? projectCount,
    int? judgeCount,
    int? voteCount,
    DateTime? createdAt,
  }) {
    return EventSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      isDemo: isDemo ?? this.isDemo,
      projectCount: projectCount ?? this.projectCount,
      judgeCount: judgeCount ?? this.judgeCount,
      voteCount: voteCount ?? this.voteCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
