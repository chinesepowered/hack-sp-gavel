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
import '../dto/note_view.dart' as _ivqr4x2t;
import '../project.dart' as _ina1x9bz;

abstract class ProjectDetail
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProjectDetail._({
    required this.project,
    required this.rank,
    required this.sigma,
    required this.wins,
    required this.losses,
    required this.notes,
  });

  factory ProjectDetail({
    required _ina1x9bz.Project project,
    required int rank,
    required double sigma,
    required int wins,
    required int losses,
    required List<_ivqr4x2t.NoteView> notes,
  }) = _ProjectDetailImpl;

  factory ProjectDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectDetail(
      project: _imkuj2yl.Protocol().deserialize<_ina1x9bz.Project>(
        jsonSerialization['project'],
      ),
      rank: jsonSerialization['rank'] as int,
      sigma: (jsonSerialization['sigma'] as num).toDouble(),
      wins: jsonSerialization['wins'] as int,
      losses: jsonSerialization['losses'] as int,
      notes: _imkuj2yl.Protocol().deserialize<List<_ivqr4x2t.NoteView>>(
        jsonSerialization['notes'],
      ),
    );
  }

  _ina1x9bz.Project project;

  int rank;

  double sigma;

  int wins;

  int losses;

  List<_ivqr4x2t.NoteView> notes;

  /// Returns a shallow copy of this [ProjectDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProjectDetail copyWith({
    _ina1x9bz.Project? project,
    int? rank,
    double? sigma,
    int? wins,
    int? losses,
    List<_ivqr4x2t.NoteView>? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectDetail',
      'project': project.toJson(),
      'rank': rank,
      'sigma': sigma,
      'wins': wins,
      'losses': losses,
      'notes': notes.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectDetail',
      'project': project.toJsonForProtocol(),
      'rank': rank,
      'sigma': sigma,
      'wins': wins,
      'losses': losses,
      'notes': notes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ProjectDetailImpl extends ProjectDetail {
  _ProjectDetailImpl({
    required _ina1x9bz.Project project,
    required int rank,
    required double sigma,
    required int wins,
    required int losses,
    required List<_ivqr4x2t.NoteView> notes,
  }) : super._(
         project: project,
         rank: rank,
         sigma: sigma,
         wins: wins,
         losses: losses,
         notes: notes,
       );

  /// Returns a shallow copy of this [ProjectDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProjectDetail copyWith({
    _ina1x9bz.Project? project,
    int? rank,
    double? sigma,
    int? wins,
    int? losses,
    List<_ivqr4x2t.NoteView>? notes,
  }) {
    return ProjectDetail(
      project: project ?? this.project.copyWith(),
      rank: rank ?? this.rank,
      sigma: sigma ?? this.sigma,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      notes: notes ?? this.notes.map((e0) => e0.copyWith()).toList(),
    );
  }
}
