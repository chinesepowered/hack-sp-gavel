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

abstract class ProjectInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProjectInput._({
    required this.name,
    required this.location,
    required this.description,
    this.team,
    this.link,
  });

  factory ProjectInput({
    required String name,
    required String location,
    required String description,
    String? team,
    String? link,
  }) = _ProjectInputImpl;

  factory ProjectInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectInput(
      name: jsonSerialization['name'] as String,
      location: jsonSerialization['location'] as String,
      description: jsonSerialization['description'] as String,
      team: jsonSerialization['team'] as String?,
      link: jsonSerialization['link'] as String?,
    );
  }

  String name;

  String location;

  String description;

  String? team;

  String? link;

  /// Returns a shallow copy of this [ProjectInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProjectInput copyWith({
    String? name,
    String? location,
    String? description,
    String? team,
    String? link,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectInput',
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
      '__className__': 'ProjectInput',
      'name': name,
      'location': location,
      'description': description,
      if (team != null) 'team': team,
      if (link != null) 'link': link,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectInputImpl extends ProjectInput {
  _ProjectInputImpl({
    required String name,
    required String location,
    required String description,
    String? team,
    String? link,
  }) : super._(
         name: name,
         location: location,
         description: description,
         team: team,
         link: link,
       );

  /// Returns a shallow copy of this [ProjectInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProjectInput copyWith({
    String? name,
    String? location,
    String? description,
    Object? team = _Undefined,
    Object? link = _Undefined,
  }) {
    return ProjectInput(
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      team: team is String? ? team : this.team,
      link: link is String? ? link : this.link,
    );
  }
}
