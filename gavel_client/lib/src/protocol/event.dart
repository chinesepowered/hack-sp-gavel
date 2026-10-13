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
import 'event_status.dart' as _ip80g9gw;

/// A judging event (a hackathon expo, a science fair, a pitch night...).
abstract class Event
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Event._({
    this.id,
    required this.name,
    this.tagline,
    required this.slug,
    required this.judgeCode,
    this.ownerId,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    this.closesAt,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    this.announcementUrl,
    this.announcementScript,
    DateTime? createdAt,
  }) : status = status ?? _ip80g9gw.EventStatus.setup,
       minViews = minViews ?? 2,
       assignmentTimeoutMinutes = assignmentTimeoutMinutes ?? 5,
       resultsPublished = resultsPublished ?? false,
       isDemo = isDemo ?? false,
       simulationRunning = simulationRunning ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Event({
    int? id,
    required String name,
    String? tagline,
    required String slug,
    required String judgeCode,
    _isc.UuidValue? ownerId,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    DateTime? closesAt,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    String? announcementUrl,
    String? announcementScript,
    DateTime? createdAt,
  }) = _EventImpl;

  factory Event.fromJson(Map<String, dynamic> jsonSerialization) {
    return Event(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      tagline: jsonSerialization['tagline'] as String?,
      slug: jsonSerialization['slug'] as String,
      judgeCode: jsonSerialization['judgeCode'] as String,
      ownerId: jsonSerialization['ownerId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['ownerId']),
      status: jsonSerialization['status'] == null
          ? null
          : _ip80g9gw.EventStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      minViews: jsonSerialization['minViews'] as int?,
      assignmentTimeoutMinutes:
          jsonSerialization['assignmentTimeoutMinutes'] as int?,
      closesAt: jsonSerialization['closesAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['closesAt']),
      resultsPublished: jsonSerialization['resultsPublished'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['resultsPublished'],
            ),
      isDemo: jsonSerialization['isDemo'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      simulationRunning: jsonSerialization['simulationRunning'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['simulationRunning'],
            ),
      announcementUrl: jsonSerialization['announcementUrl'] as String?,
      announcementScript: jsonSerialization['announcementScript'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? tagline;

  /// Public, URL-safe identifier used for share links and the results page.
  String slug;

  /// Short code judges type (or scan) to join.
  String judgeCode;

  /// The auth user that created the event.
  _isc.UuidValue? ownerId;

  _ip80g9gw.EventStatus status;

  /// Every project should be seen at least this many times before the
  /// ranking engine optimizes purely for information gain.
  int minViews;

  /// A project a judge was sent to counts as busy for this long.
  int assignmentTimeoutMinutes;

  /// When set, judging closes automatically at this time (future call).
  DateTime? closesAt;

  /// When the public results page is visible.
  bool resultsPublished;

  /// Sandbox events created from "Try the demo"; expire after 24h.
  bool isDemo;

  bool simulationRunning;

  /// Public URL of the ElevenLabs awards announcement, once generated.
  String? announcementUrl;

  String? announcementScript;

  DateTime createdAt;

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Event copyWith({
    int? id,
    String? name,
    String? tagline,
    String? slug,
    String? judgeCode,
    _isc.UuidValue? ownerId,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    DateTime? closesAt,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    String? announcementUrl,
    String? announcementScript,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id,
      'name': name,
      if (tagline != null) 'tagline': tagline,
      'slug': slug,
      'judgeCode': judgeCode,
      if (ownerId != null) 'ownerId': ownerId?.toJson(),
      'status': status.toJson(),
      'minViews': minViews,
      'assignmentTimeoutMinutes': assignmentTimeoutMinutes,
      if (closesAt != null) 'closesAt': closesAt?.toJson(),
      'resultsPublished': resultsPublished,
      'isDemo': isDemo,
      'simulationRunning': simulationRunning,
      if (announcementUrl != null) 'announcementUrl': announcementUrl,
      if (announcementScript != null) 'announcementScript': announcementScript,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id,
      'name': name,
      if (tagline != null) 'tagline': tagline,
      'slug': slug,
      'judgeCode': judgeCode,
      if (ownerId != null) 'ownerId': ownerId?.toJson(),
      'status': status.toJson(),
      'minViews': minViews,
      'assignmentTimeoutMinutes': assignmentTimeoutMinutes,
      if (closesAt != null) 'closesAt': closesAt?.toJson(),
      'resultsPublished': resultsPublished,
      'isDemo': isDemo,
      'simulationRunning': simulationRunning,
      if (announcementUrl != null) 'announcementUrl': announcementUrl,
      if (announcementScript != null) 'announcementScript': announcementScript,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventImpl extends Event {
  _EventImpl({
    int? id,
    required String name,
    String? tagline,
    required String slug,
    required String judgeCode,
    _isc.UuidValue? ownerId,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    DateTime? closesAt,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    String? announcementUrl,
    String? announcementScript,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         tagline: tagline,
         slug: slug,
         judgeCode: judgeCode,
         ownerId: ownerId,
         status: status,
         minViews: minViews,
         assignmentTimeoutMinutes: assignmentTimeoutMinutes,
         closesAt: closesAt,
         resultsPublished: resultsPublished,
         isDemo: isDemo,
         simulationRunning: simulationRunning,
         announcementUrl: announcementUrl,
         announcementScript: announcementScript,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Event copyWith({
    Object? id = _Undefined,
    String? name,
    Object? tagline = _Undefined,
    String? slug,
    String? judgeCode,
    Object? ownerId = _Undefined,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    Object? closesAt = _Undefined,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    Object? announcementUrl = _Undefined,
    Object? announcementScript = _Undefined,
    DateTime? createdAt,
  }) {
    return Event(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      tagline: tagline is String? ? tagline : this.tagline,
      slug: slug ?? this.slug,
      judgeCode: judgeCode ?? this.judgeCode,
      ownerId: ownerId is _isc.UuidValue? ? ownerId : this.ownerId,
      status: status ?? this.status,
      minViews: minViews ?? this.minViews,
      assignmentTimeoutMinutes:
          assignmentTimeoutMinutes ?? this.assignmentTimeoutMinutes,
      closesAt: closesAt is DateTime? ? closesAt : this.closesAt,
      resultsPublished: resultsPublished ?? this.resultsPublished,
      isDemo: isDemo ?? this.isDemo,
      simulationRunning: simulationRunning ?? this.simulationRunning,
      announcementUrl: announcementUrl is String?
          ? announcementUrl
          : this.announcementUrl,
      announcementScript: announcementScript is String?
          ? announcementScript
          : this.announcementScript,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
