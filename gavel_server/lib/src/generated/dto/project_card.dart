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

/// What a judge sees about a project.
abstract class ProjectCard
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProjectCard._({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    this.team,
    this.link,
  });

  factory ProjectCard({
    required int id,
    required String name,
    required String location,
    required String description,
    String? team,
    String? link,
  }) = _ProjectCardImpl;

  factory ProjectCard.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectCard(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      location: jsonSerialization['location'] as String,
      description: jsonSerialization['description'] as String,
      team: jsonSerialization['team'] as String?,
      link: jsonSerialization['link'] as String?,
    );
  }

  int id;

  String name;

  String location;

  String description;

  String? team;

  String? link;

  /// Returns a shallow copy of this [ProjectCard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProjectCard copyWith({
    int? id,
    String? name,
    String? location,
    String? description,
    String? team,
    String? link,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectCard',
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      if (team != null) 'team': team,
      if (link != null) 'link': link,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectCard',
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      if (team != null) 'team': team,
      if (link != null) 'link': link,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectCardImpl extends ProjectCard {
  _ProjectCardImpl({
    required int id,
    required String name,
    required String location,
    required String description,
    String? team,
    String? link,
  }) : super._(
         id: id,
         name: name,
         location: location,
         description: description,
         team: team,
         link: link,
       );

  /// Returns a shallow copy of this [ProjectCard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProjectCard copyWith({
    int? id,
    String? name,
    String? location,
    String? description,
    Object? team = _Undefined,
    Object? link = _Undefined,
  }) {
    return ProjectCard(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      team: team is String? ? team : this.team,
      link: link is String? ? link : this.link,
    );
  }
}
