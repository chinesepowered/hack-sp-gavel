import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:serverpod/serverpod.dart';

/// Thin client for the ElevenLabs REST API.
///
/// The API key lives in Serverpod's password store (`elevenLabsApiKey` in
/// `config/passwords.yaml` locally, `serverpod cloud password set` in
/// production) and never reaches the app.
class ElevenLabs {
  ElevenLabs(this.apiKey);

  final String apiKey;

  static const _base = 'https://api.elevenlabs.io/v1';

  /// "George": a warm, captivating storyteller voice for the awards.
  static const announcerVoiceId = 'JBFqnCBsd6RMkjVDRZzb';
  static const ttsModel = 'eleven_multilingual_v2';
  static const sttModel = 'scribe_v2';

  /// Returns a client if the API key is configured.
  static ElevenLabs? fromSession(Session session) {
    final key = session.passwords['elevenLabsApiKey'];
    if (key == null || key.isEmpty) return null;
    return ElevenLabs(key);
  }

  /// Text to speech, returns MP3 bytes.
  Future<Uint8List> speak(
    String text, {
    String voiceId = announcerVoiceId,
  }) async {
    final response = await http.post(
      Uri.parse('$_base/text-to-speech/$voiceId?output_format=mp3_44100_128'),
      headers: {
        'xi-api-key': apiKey,
        'content-type': 'application/json',
        'accept': 'audio/mpeg',
      },
      body: jsonEncode({
        'text': text,
        'model_id': ttsModel,
        'voice_settings': {
          'stability': 0.45,
          'similarity_boost': 0.8,
          'style': 0.35,
          'use_speaker_boost': true,
        },
      }),
    );
    if (response.statusCode != 200) {
      throw ElevenLabsException(
        'Text to speech failed (${response.statusCode}): ${response.body}',
      );
    }
    return response.bodyBytes;
  }

  /// Speech to text (Scribe), returns the transcript.
  Future<String> transcribe(
    Uint8List audio, {
    required String filename,
    required String mimeType,
  }) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('$_base/speech-to-text'))
          ..headers['xi-api-key'] = apiKey
          ..fields['model_id'] = sttModel
          ..fields['tag_audio_events'] = 'false'
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              audio,
              filename: filename,
              contentType: _mediaType(mimeType),
            ),
          );
    final streamed = await request.send();
    final body = await streamed.stream.bytesToString();
    if (streamed.statusCode != 200) {
      throw ElevenLabsException(
        'Speech to text failed (${streamed.statusCode}): $body',
      );
    }
    final json = jsonDecode(body) as Map<String, dynamic>;
    return (json['text'] as String? ?? '').trim();
  }

  static MediaType? _mediaType(String mimeType) {
    try {
      return MediaType.parse(mimeType);
    } catch (_) {
      return null;
    }
  }
}

class ElevenLabsException implements Exception {
  ElevenLabsException(this.message);
  final String message;

  @override
  String toString() => 'ElevenLabsException: $message';
}
