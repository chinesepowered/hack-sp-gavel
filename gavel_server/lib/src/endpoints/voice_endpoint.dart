import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/elevenlabs.dart';
import '../services/judging_service.dart';
import 'judge_endpoint.dart';

/// Voice features powered by ElevenLabs. The API key stays on the server.
class VoiceEndpoint extends Endpoint {
  /// Whether voice features are configured on this server.
  Future<bool> available(Session session) async =>
      ElevenLabs.fromSession(session) != null;

  /// A judge dictates a note on their phone; ElevenLabs Scribe turns it into
  /// text that organizers see next to the project.
  Future<NoteView> transcribeNote(
    Session session,
    String token,
    int projectId,
    ByteData audio,
    String mimeType,
  ) async {
    final judge = await JudgingService.judgeForToken(session, token);
    final voice = ElevenLabs.fromSession(session);
    if (voice == null) {
      throw GavelException(message: 'Voice notes are not configured.');
    }
    if (audio.lengthInBytes > 1500000) {
      throw GavelException(message: 'Keep voice notes under a minute.');
    }
    final extension = mimeType.contains('wav')
        ? 'wav'
        : mimeType.contains('mp4') || mimeType.contains('m4a')
        ? 'm4a'
        : mimeType.contains('ogg')
        ? 'ogg'
        : 'webm';
    final String transcript;
    try {
      transcript = await voice.transcribe(
        audio.buffer.asUint8List(audio.offsetInBytes, audio.lengthInBytes),
        filename: 'note.$extension',
        mimeType: mimeType,
      );
    } on ElevenLabsException catch (e, stackTrace) {
      session.log(
        'Transcription failed',
        level: LogLevel.warning,
        exception: e,
        stackTrace: stackTrace,
      );
      throw GavelException(message: 'Could not transcribe that note.');
    }
    if (transcript.isEmpty) {
      throw GavelException(message: 'We did not catch that, try again.');
    }
    return JudgeEndpoint.saveNote(
      session,
      judge,
      projectId,
      transcript,
      NoteSource.voice,
    );
  }
}
