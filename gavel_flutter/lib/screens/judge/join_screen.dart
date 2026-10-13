import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gavel_client/gavel_client.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import '../../widgets/gavel_logo.dart';
import 'judge_storage.dart';

/// Where the event QR code lands: pick a name and start judging.
class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key, this.code});
  final String? code;

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final _name = TextEditingController();
  final _codeField = TextEditingController();
  EventPublicInfo? _info;
  String? _error;
  String? _existingToken;
  String? _existingName;
  bool _busy = false;

  String? get _code => widget.code?.toUpperCase();

  @override
  void initState() {
    super.initState();
    if (_code != null) _load();
  }

  @override
  void dispose() {
    _name.dispose();
    _codeField.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final info = await client.judge.lookup(_code!);
      final token = await JudgeStorage.tokenFor(_code!);
      String? existingName;
      if (token != null) {
        try {
          existingName = (await client.judge.state(token)).judgeName;
        } catch (_) {}
      }
      if (!mounted) return;
      setState(() {
        _info = info;
        _existingToken = existingName == null ? null : token;
        _existingName = existingName;
      });
    } catch (e) {
      if (mounted) setState(() => _error = friendlyError(e));
    }
  }

  Future<void> _join() async {
    if (_name.text.trim().isEmpty || _busy) return;
    setState(() => _busy = true);
    try {
      final result = await client.judge.join(_code!, _name.text);
      await JudgeStorage.save(_code!, result.token);
      if (mounted) context.go('/judge/${result.token}');
    } catch (e) {
      if (mounted) showError(context, friendlyError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_code == null) {
      body = _codeEntry();
    } else if (_error != null) {
      body = CenteredMessage(
        icon: Icons.search_off_rounded,
        title: 'Event not found',
        body: _error,
        action: OutlinedButton(
          onPressed: () => context.go('/join'),
          child: const Text('Try another code'),
        ),
      );
    } else if (_info == null) {
      body = const LoadingView(label: 'Finding your event…');
    } else {
      body = _form(_info!);
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => context.go('/'),
                    child: const GavelWordmark(size: 32),
                  ),
                  const SizedBox(height: 36),
                  body,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _codeEntry() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('JOIN AS A JUDGE', style: G.eyebrow()),
      const SizedBox(height: 12),
      Text('What’s your event code?', style: G.serif(size: 34)),
      const SizedBox(height: 24),
      TextField(
        controller: _codeField,
        textCapitalization: TextCapitalization.characters,
        style: G.mono(size: 24, weight: FontWeight.w600),
        decoration: const InputDecoration(hintText: 'K7Q2XD'),
        onSubmitted: (v) => context.go('/join/${v.trim().toUpperCase()}'),
      ),
      const SizedBox(height: 16),
      FilledButton(
        onPressed: () =>
            context.go('/join/${_codeField.text.trim().toUpperCase()}'),
        child: const Text('Continue'),
      ),
    ],
  );

  Widget _form(EventPublicInfo info) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Text('YOU’RE INVITED TO JUDGE', style: G.eyebrow()),
          const Spacer(),
          StatusChip(status: info.status),
        ],
      ),
      const SizedBox(height: 14),
      Text(info.name, style: G.serif(size: 40)),
      if (info.tagline != null) ...[
        const SizedBox(height: 10),
        Text(info.tagline!, style: G.sans(color: G.muted, size: 16)),
      ],
      const SizedBox(height: 18),
      Text(
        '${info.projectCount} project${info.projectCount == 1 ? '' : 's'} · '
        '${info.judgeCount} judge${info.judgeCount == 1 ? '' : 's'} so far',
        style: G.mono(size: 13, color: G.muted),
      ),
      const SizedBox(height: 28),
      if (_existingToken != null) ...[
        FilledButton.icon(
          onPressed: () => context.go('/judge/$_existingToken'),
          icon: const Icon(Icons.play_arrow_rounded),
          label: Text('Continue as $_existingName'),
        ),
        const SizedBox(height: 20),
        Text(
          'Or join as someone else:',
          style: G.sans(color: G.muted, size: 14),
        ),
        const SizedBox(height: 10),
      ],
      TextField(
        key: const Key('judge-name'),
        controller: _name,
        textCapitalization: TextCapitalization.words,
        style: G.sans(size: 18, weight: FontWeight.w600),
        decoration: const InputDecoration(labelText: 'Your name'),
        onSubmitted: (_) => _join(),
      ),
      const SizedBox(height: 14),
      FilledButton(
        key: const Key('start-judging'),
        onPressed: _busy ? null : _join,
        child: Text(_busy ? 'Joining…' : 'Start judging'),
      ),
      const SizedBox(height: 26),
      Panel(
        color: G.ink,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _step('1', 'We send you to a table.'),
            _step('2', 'Look at the project. Ask questions.'),
            _step('3', 'Tell us if it beat the previous one. That’s it.'),
          ],
        ),
      ),
    ],
  );

  Widget _step(String n, String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Text(
          n,
          style: G.mono(color: G.brass, weight: FontWeight.w700),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(text, style: G.sans(color: G.muted)),
        ),
      ],
    ),
  );
}
