import 'package:shared_preferences/shared_preferences.dart';

/// Remembers judge seats on this device so a refresh never loses progress.
class JudgeStorage {
  JudgeStorage._();

  static String _key(String code) => 'gavel.judge.${code.toUpperCase()}';

  static Future<void> save(String code, String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key(code), token);
      await prefs.setString('gavel.judge.last', token);
    } catch (_) {
      // Storage can be unavailable (private mode); the magic link still works.
    }
  }

  static Future<String?> tokenFor(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_key(code));
    } catch (_) {
      return null;
    }
  }
}
