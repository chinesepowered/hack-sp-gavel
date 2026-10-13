import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

/// Lets a judge leave a note on the project they are visiting: typed, or
/// dictated and transcribed by ElevenLabs Scribe on the server.
class NoteComposer extends StatefulWidget {
  const NoteComposer({
    super.key,
    required this.token,
    required this.projectId,
    required this.voiceEnabled,
  });

  final String token;
  final int projectId;
  final bool voiceEnabled;

  @override
  State<NoteComposer> createState() => _NoteComposerState();
}

class _NoteComposerState extends State<NoteComposer> {
  static const _sampleRate = 16000;
  static const _maxDuration = Duration(seconds: 30);

  final _text = TextEditingController();
  final _recorder = AudioRecorder();
  final _chunks = BytesBuilder(copy: false);
  StreamSubscription<Uint8List>? _audio;
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  bool _recording = false;
  bool _sending = false;
  final _saved = <String>[];

  @override
  void dispose() {
    _ticker?.cancel();
    _audio?.cancel();
    _recorder.dispose();
    _text.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (_recording) {
      await _stopAndSend();
      return;
    }
    try {
      if (!await _recorder.hasPermission()) {
        if (mounted) showError(context, 'Microphone access was denied.');
        return;
      }
      _chunks.clear();
      final stream = await _recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: _sampleRate,
          numChannels: 1,
        ),
      );
      _audio = stream.listen(_chunks.add);
      _elapsed = Duration.zero;
      _ticker = Timer.periodic(const Duration(milliseconds: 200), (t) {
        setState(() => _elapsed += const Duration(milliseconds: 200));
        if (_elapsed >= _maxDuration) _stopAndSend();
      });
      setState(() => _recording = true);
    } catch (e) {
      if (mounted) showError(context, 'Could not start recording.');
    }
  }

  Future<void> _stopAndSend() async {
    _ticker?.cancel();
    await _recorder.stop();
    await _audio?.cancel();
    setState(() {
      _recording = false;
      _sending = true;
    });
    try {
      final pcm = _chunks.takeBytes();
      if (pcm.length < _sampleRate) {
        throw StateError('too short');
      }
      final wav = _wav(pcm, _sampleRate);
      final note = await client.voice.transcribeNote(
        widget.token,
        widget.projectId,
        ByteData.sublistView(wav),
        'audio/wav',
      );
      if (mounted) setState(() => _saved.insert(0, note.text));
    } catch (e) {
      if (mounted) {
        showError(
          context,
          e is StateError ? 'That note was too short.' : friendlyError(e),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _sendText() async {
    final text = _text.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      final note = await client.judge.addNote(
        widget.token,
        widget.projectId,
        text,
      );
      _text.clear();
      if (mounted) setState(() => _saved.insert(0, note.text));
    } catch (e) {
      if (mounted) showError(context, friendlyError(e));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Panel(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      color: G.ink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _text,
                  minLines: 1,
                  maxLines: 3,
                  style: G.sans(size: 14.5),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: _recording
                        ? 'Listening… tap stop when done'
                        : 'Private note for organizers',
                  ),
                  onSubmitted: (_) => _sendText(),
                ),
              ),
              const SizedBox(width: 10),
              if (widget.voiceEnabled)
                _MicButton(
                  recording: _recording,
                  busy: _sending,
                  elapsed: _elapsed,
                  onTap: _sending ? null : _toggleRecording,
                ),
              IconButton(
                tooltip: 'Save note',
                onPressed: _sending || _recording ? null : _sendText,
                icon: const Icon(Icons.send_rounded, color: G.brass),
              ),
            ],
          ),
          if (_sending && !_recording)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: G.brass,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Transcribing with ElevenLabs…',
                    style: G.sans(size: 13, color: G.muted),
                  ),
                ],
              ),
            ),
          for (final note in _saved.take(2))
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.format_quote_rounded,
                    size: 18,
                    color: G.mint,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      note,
                      style: G.sans(size: 13.5, color: G.paper, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Wraps raw 16-bit mono PCM in a WAV container.
  static Uint8List _wav(Uint8List pcm, int sampleRate) {
    final header = ByteData(44);
    void ascii(int offset, String s) {
      for (var i = 0; i < s.length; i++) {
        header.setUint8(offset + i, s.codeUnitAt(i));
      }
    }

    ascii(0, 'RIFF');
    header.setUint32(4, 36 + pcm.length, Endian.little);
    ascii(8, 'WAVE');
    ascii(12, 'fmt ');
    header.setUint32(16, 16, Endian.little);
    header.setUint16(20, 1, Endian.little); // PCM
    header.setUint16(22, 1, Endian.little); // mono
    header.setUint32(24, sampleRate, Endian.little);
    header.setUint32(28, sampleRate * 2, Endian.little);
    header.setUint16(32, 2, Endian.little);
    header.setUint16(34, 16, Endian.little);
    ascii(36, 'data');
    header.setUint32(40, pcm.length, Endian.little);
    return (BytesBuilder(copy: false)
          ..add(header.buffer.asUint8List())
          ..add(pcm))
        .takeBytes();
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({
    required this.recording,
    required this.busy,
    required this.elapsed,
    required this.onTap,
  });

  final bool recording;
  final bool busy;
  final Duration elapsed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: recording ? 'Stop and transcribe' : 'Dictate a note',
      child: InkWell(
        key: const Key('voice-note'),
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: recording ? 14 : 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: recording ? G.signal : G.ink3,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                recording ? Icons.stop_rounded : Icons.mic_rounded,
                size: 20,
                color: recording ? G.paper : G.brass,
              ),
              if (recording) ...[
                const SizedBox(width: 6),
                Text(
                  '0:${elapsed.inSeconds.toString().padLeft(2, '0')}',
                  style: G.mono(size: 13, weight: FontWeight.w700),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
