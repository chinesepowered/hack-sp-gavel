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
import 'package:gavel_client/src/protocol/protocol.dart' as _ivmqq51r;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../dto/project_card.dart' as _ii4rdm1k;
import '../event_status.dart' as _itfhxk01;
import '../judge_phase.dart' as _i76kmwid;

/// Everything the judge's phone needs to render the current step.
abstract class JudgeState
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JudgeState._({
    required this.judgeId,
    required this.judgeName,
    required this.eventName,
    required this.eventStatus,
    required this.phase,
    this.current,
    this.previous,
    required this.votesCast,
    required this.projectsSeen,
    required this.projectsTotal,
    this.notice,
    required this.voiceNotesEnabled,
  });

  factory JudgeState({
    required int judgeId,
    required String judgeName,
    required String eventName,
    required _itfhxk01.EventStatus eventStatus,
    required _i76kmwid.JudgePhase phase,
    _ii4rdm1k.ProjectCard? current,
    _ii4rdm1k.ProjectCard? previous,
    required int votesCast,
    required int projectsSeen,
    required int projectsTotal,
    String? notice,
    required bool voiceNotesEnabled,
  }) = _JudgeStateImpl;

  factory JudgeState.fromJson(Map<String, dynamic> jsonSerialization) {
    return JudgeState(
      judgeId: jsonSerialization['judgeId'] as int,
      judgeName: jsonSerialization['judgeName'] as String,
      eventName: jsonSerialization['eventName'] as String,
      eventStatus: _itfhxk01.EventStatus.fromJson(
        (jsonSerialization['eventStatus'] as String),
      ),
      phase: _i76kmwid.JudgePhase.fromJson(
        (jsonSerialization['phase'] as String),
      ),
      current: jsonSerialization['current'] == null
          ? null
          : _ivmqq51r.Protocol().deserialize<_ii4rdm1k.ProjectCard>(
              jsonSerialization['current'],
            ),
      previous: jsonSerialization['previous'] == null
          ? null
          : _ivmqq51r.Protocol().deserialize<_ii4rdm1k.ProjectCard>(
              jsonSerialization['previous'],
            ),
      votesCast: jsonSerialization['votesCast'] as int,
      projectsSeen: jsonSerialization['projectsSeen'] as int,
      projectsTotal: jsonSerialization['projectsTotal'] as int,
      notice: jsonSerialization['notice'] as String?,
      voiceNotesEnabled: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['voiceNotesEnabled'],
      ),
    );
  }

  int judgeId;

  String judgeName;

  String eventName;

  _itfhxk01.EventStatus eventStatus;

  _i76kmwid.JudgePhase phase;

  _ii4rdm1k.ProjectCard? current;

  _ii4rdm1k.ProjectCard? previous;

  int votesCast;

  int projectsSeen;

  int projectsTotal;

  /// Short message for the judge (e.g. "Table 7 was marked absent, rerouted").
  String? notice;

  bool voiceNotesEnabled;

  /// Returns a shallow copy of this [JudgeState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JudgeState copyWith({
    int? judgeId,
    String? judgeName,
    String? eventName,
    _itfhxk01.EventStatus? eventStatus,
    _i76kmwid.JudgePhase? phase,
    _ii4rdm1k.ProjectCard? current,
    _ii4rdm1k.ProjectCard? previous,
    int? votesCast,
    int? projectsSeen,
    int? projectsTotal,
    String? notice,
    bool? voiceNotesEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JudgeState',
      'judgeId': judgeId,
      'judgeName': judgeName,
      'eventName': eventName,
      'eventStatus': eventStatus.toJson(),
      'phase': phase.toJson(),
      if (current != null) 'current': current?.toJson(),
      if (previous != null) 'previous': previous?.toJson(),
      'votesCast': votesCast,
      'projectsSeen': projectsSeen,
      'projectsTotal': projectsTotal,
      if (notice != null) 'notice': notice,
      'voiceNotesEnabled': voiceNotesEnabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JudgeState',
      'judgeId': judgeId,
      'judgeName': judgeName,
      'eventName': eventName,
      'eventStatus': eventStatus.toJson(),
      'phase': phase.toJson(),
      if (current != null) 'current': current?.toJsonForProtocol(),
      if (previous != null) 'previous': previous?.toJsonForProtocol(),
      'votesCast': votesCast,
      'projectsSeen': projectsSeen,
      'projectsTotal': projectsTotal,
      if (notice != null) 'notice': notice,
      'voiceNotesEnabled': voiceNotesEnabled,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JudgeStateImpl extends JudgeState {
  _JudgeStateImpl({
    required int judgeId,
    required String judgeName,
    required String eventName,
    required _itfhxk01.EventStatus eventStatus,
    required _i76kmwid.JudgePhase phase,
    _ii4rdm1k.ProjectCard? current,
    _ii4rdm1k.ProjectCard? previous,
    required int votesCast,
    required int projectsSeen,
    required int projectsTotal,
    String? notice,
    required bool voiceNotesEnabled,
  }) : super._(
         judgeId: judgeId,
         judgeName: judgeName,
         eventName: eventName,
         eventStatus: eventStatus,
         phase: phase,
         current: current,
         previous: previous,
         votesCast: votesCast,
         projectsSeen: projectsSeen,
         projectsTotal: projectsTotal,
         notice: notice,
         voiceNotesEnabled: voiceNotesEnabled,
       );

  /// Returns a shallow copy of this [JudgeState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JudgeState copyWith({
    int? judgeId,
    String? judgeName,
    String? eventName,
    _itfhxk01.EventStatus? eventStatus,
    _i76kmwid.JudgePhase? phase,
    Object? current = _Undefined,
    Object? previous = _Undefined,
    int? votesCast,
    int? projectsSeen,
    int? projectsTotal,
    Object? notice = _Undefined,
    bool? voiceNotesEnabled,
  }) {
    return JudgeState(
      judgeId: judgeId ?? this.judgeId,
      judgeName: judgeName ?? this.judgeName,
      eventName: eventName ?? this.eventName,
      eventStatus: eventStatus ?? this.eventStatus,
      phase: phase ?? this.phase,
      current: current is _ii4rdm1k.ProjectCard?
          ? current
          : this.current?.copyWith(),
      previous: previous is _ii4rdm1k.ProjectCard?
          ? previous
          : this.previous?.copyWith(),
      votesCast: votesCast ?? this.votesCast,
      projectsSeen: projectsSeen ?? this.projectsSeen,
      projectsTotal: projectsTotal ?? this.projectsTotal,
      notice: notice is String? ? notice : this.notice,
      voiceNotesEnabled: voiceNotesEnabled ?? this.voiceNotesEnabled,
    );
  }
}
