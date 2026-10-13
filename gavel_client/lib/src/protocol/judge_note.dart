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
import 'note_source.dart' as _imwmkxfc;

/// A note a judge left about a project, typed or dictated (ElevenLabs STT).
abstract class JudgeNote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JudgeNote._({
    this.id,
    required this.eventId,
    required this.judgeId,
    required this.projectId,
    required this.text,
    required this.source,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory JudgeNote({
    int? id,
    required int eventId,
    required int judgeId,
    required int projectId,
    required String text,
    required _imwmkxfc.NoteSource source,
    DateTime? createdAt,
  }) = _JudgeNoteImpl;

  factory JudgeNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return JudgeNote(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      judgeId: jsonSerialization['judgeId'] as int,
      projectId: jsonSerialization['projectId'] as int,
      text: jsonSerialization['text'] as String,
      source: _imwmkxfc.NoteSource.fromJson(
        (jsonSerialization['source'] as String),
      ),
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

  int judgeId;

  int projectId;

  String text;

  _imwmkxfc.NoteSource source;

  DateTime createdAt;

  /// Returns a shallow copy of this [JudgeNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JudgeNote copyWith({
    int? id,
    int? eventId,
    int? judgeId,
    int? projectId,
    String? text,
    _imwmkxfc.NoteSource? source,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JudgeNote',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'projectId': projectId,
      'text': text,
      'source': source.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JudgeNote',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'projectId': projectId,
      'text': text,
      'source': source.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JudgeNoteImpl extends JudgeNote {
  _JudgeNoteImpl({
    int? id,
    required int eventId,
    required int judgeId,
    required int projectId,
    required String text,
    required _imwmkxfc.NoteSource source,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         judgeId: judgeId,
         projectId: projectId,
         text: text,
         source: source,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [JudgeNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JudgeNote copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? judgeId,
    int? projectId,
    String? text,
    _imwmkxfc.NoteSource? source,
    DateTime? createdAt,
  }) {
    return JudgeNote(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      judgeId: judgeId ?? this.judgeId,
      projectId: projectId ?? this.projectId,
      text: text ?? this.text,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
