import 'dart:math' as math;

final _secure = math.Random.secure();

/// Unambiguous characters for codes people read off a screen or type.
const _codeAlphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
const _tokenAlphabet =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

/// A short, human friendly join code such as `K7Q2XD`.
String newJoinCode([int length = 6]) => List.generate(
  length,
  (_) => _codeAlphabet[_secure.nextInt(_codeAlphabet.length)],
).join();

/// An unguessable secret for magic links (judge tokens, admin keys).
String newSecret([int length = 32]) => List.generate(
  length,
  (_) => _tokenAlphabet[_secure.nextInt(_tokenAlphabet.length)],
).join();

/// Turns an event name into a URL-safe slug with a random suffix.
String slugify(String name) {
  final base = name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  final trimmed = base.length > 32 ? base.substring(0, 32) : base;
  final suffix = newJoinCode(4).toLowerCase();
  return trimmed.isEmpty ? 'event-$suffix' : '$trimmed-$suffix';
}
