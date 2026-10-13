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
import '../dto/leaderboard_entry.dart' as _iqfcxba5;

/// The awards ceremony script and its ElevenLabs narration.
abstract class Announcement
    implements _is.SerializableModel, _is.ProtocolSerialization {
  Announcement._({
    required this.script,
    this.audioUrl,
    required this.podium,
  });

  factory Announcement({
    required String script,
    String? audioUrl,
    required List<_iqfcxba5.LeaderboardEntry> podium,
  }) = _AnnouncementImpl;

  factory Announcement.fromJson(Map<String, dynamic> jsonSerialization) {
    return Announcement(
      script: jsonSerialization['script'] as String,
      audioUrl: jsonSerialization['audioUrl'] as String?,
      podium: _imkuj2yl.Protocol()
          .deserialize<List<_iqfcxba5.LeaderboardEntry>>(
            jsonSerialization['podium'],
          ),
    );
  }

  String script;

  String? audioUrl;

  List<_iqfcxba5.LeaderboardEntry> podium;

  /// Returns a shallow copy of this [Announcement]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Announcement copyWith({
    String? script,
    String? audioUrl,
    List<_iqfcxba5.LeaderboardEntry>? podium,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Announcement',
      'script': script,
      if (audioUrl != null) 'audioUrl': audioUrl,
      'podium': podium.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Announcement',
      'script': script,
      if (audioUrl != null) 'audioUrl': audioUrl,
      'podium': podium.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnnouncementImpl extends Announcement {
  _AnnouncementImpl({
    required String script,
    String? audioUrl,
    required List<_iqfcxba5.LeaderboardEntry> podium,
  }) : super._(
         script: script,
         audioUrl: audioUrl,
         podium: podium,
       );

  /// Returns a shallow copy of this [Announcement]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Announcement copyWith({
    String? script,
    Object? audioUrl = _Undefined,
    List<_iqfcxba5.LeaderboardEntry>? podium,
  }) {
    return Announcement(
      script: script ?? this.script,
      audioUrl: audioUrl is String? ? audioUrl : this.audioUrl,
      podium: podium ?? this.podium.map((e0) => e0.copyWith()).toList(),
    );
  }
}
