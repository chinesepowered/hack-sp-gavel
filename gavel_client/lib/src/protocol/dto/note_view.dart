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
import '../note_source.dart' as _i9th8tfk;

abstract class NoteView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  NoteView._({
    required this.judgeName,
    required this.text,
    required this.source,
    required this.createdAt,
  });

  factory NoteView({
    required String judgeName,
    required String text,
    required _i9th8tfk.NoteSource source,
    required DateTime createdAt,
  }) = _NoteViewImpl;

  factory NoteView.fromJson(Map<String, dynamic> jsonSerialization) {
    return NoteView(
      judgeName: jsonSerialization['judgeName'] as String,
      text: jsonSerialization['text'] as String,
      source: _i9th8tfk.NoteSource.fromJson(
        (jsonSerialization['source'] as String),
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  String judgeName;

  String text;

  _i9th8tfk.NoteSource source;

  DateTime createdAt;

  /// Returns a shallow copy of this [NoteView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  NoteView copyWith({
    String? judgeName,
    String? text,
    _i9th8tfk.NoteSource? source,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NoteView',
      'judgeName': judgeName,
      'text': text,
      'source': source.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NoteView',
      'judgeName': judgeName,
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

class _NoteViewImpl extends NoteView {
  _NoteViewImpl({
    required String judgeName,
    required String text,
    required _i9th8tfk.NoteSource source,
    required DateTime createdAt,
  }) : super._(
         judgeName: judgeName,
         text: text,
         source: source,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [NoteView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  NoteView copyWith({
    String? judgeName,
    String? text,
    _i9th8tfk.NoteSource? source,
    DateTime? createdAt,
  }) {
    return NoteView(
      judgeName: judgeName ?? this.judgeName,
      text: text ?? this.text,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
