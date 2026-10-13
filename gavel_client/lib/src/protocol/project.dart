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

/// A project (team / table) competing in an event.
abstract class Project
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Project._({
    this.id,
    required this.eventId,
    required this.name,
    required this.location,
    required this.description,
    this.team,
    this.link,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    DateTime? createdAt,
  }) : mu = mu ?? 0.0,
       sigmaSq = sigmaSq ?? 1.0,
       active = active ?? true,
       prioritized = prioritized ?? false,
       timesSeen = timesSeen ?? 0,
       absentReports = absentReports ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Project({
    int? id,
    required int eventId,
    required String name,
    required String location,
    required String description,
    String? team,
    String? link,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    DateTime? createdAt,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      name: jsonSerialization['name'] as String,
      location: jsonSerialization['location'] as String,
      description: jsonSerialization['description'] as String,
      team: jsonSerialization['team'] as String?,
      link: jsonSerialization['link'] as String?,
      mu: (jsonSerialization['mu'] as num?)?.toDouble(),
      sigmaSq: (jsonSerialization['sigmaSq'] as num?)?.toDouble(),
      active: jsonSerialization['active'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
      prioritized: jsonSerialization['prioritized'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['prioritized']),
      timesSeen: jsonSerialization['timesSeen'] as int?,
      absentReports: jsonSerialization['absentReports'] as int?,
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

  String name;

  /// Where judges find it, e.g. "Table 12".
  String location;

  String description;

  String? team;

  String? link;

  /// Crowd-BT posterior: mean quality estimate.
  double mu;

  /// Crowd-BT posterior: variance of the quality estimate.
  double sigmaSq;

  /// Inactive projects are never assigned (absent, withdrawn...).
  bool active;

  /// Prioritized projects are visited before everything else.
  bool prioritized;

  int timesSeen;

  int absentReports;

  DateTime createdAt;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Project copyWith({
    int? id,
    int? eventId,
    String? name,
    String? location,
    String? description,
    String? team,
    String? link,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'location': location,
      'description': description,
      if (team != null) 'team': team,
      if (link != null) 'link': link,
      'mu': mu,
      'sigmaSq': sigmaSq,
      'active': active,
      'prioritized': prioritized,
      'timesSeen': timesSeen,
      'absentReports': absentReports,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'location': location,
      'description': description,
      if (team != null) 'team': team,
      if (link != null) 'link': link,
      'mu': mu,
      'sigmaSq': sigmaSq,
      'active': active,
      'prioritized': prioritized,
      'timesSeen': timesSeen,
      'absentReports': absentReports,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectImpl extends Project {
  _ProjectImpl({
    int? id,
    required int eventId,
    required String name,
    required String location,
    required String description,
    String? team,
    String? link,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         name: name,
         location: location,
         description: description,
         team: team,
         link: link,
         mu: mu,
         sigmaSq: sigmaSq,
         active: active,
         prioritized: prioritized,
         timesSeen: timesSeen,
         absentReports: absentReports,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Project copyWith({
    Object? id = _Undefined,
    int? eventId,
    String? name,
    String? location,
    String? description,
    Object? team = _Undefined,
    Object? link = _Undefined,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    DateTime? createdAt,
  }) {
    return Project(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      team: team is String? ? team : this.team,
      link: link is String? ? link : this.link,
      mu: mu ?? this.mu,
      sigmaSq: sigmaSq ?? this.sigmaSq,
      active: active ?? this.active,
      prioritized: prioritized ?? this.prioritized,
      timesSeen: timesSeen ?? this.timesSeen,
      absentReports: absentReports ?? this.absentReports,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
