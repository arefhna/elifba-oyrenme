import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const String _learnedKey = 'learned_letters';
  static const String _quizBestKey = 'quiz_best_score';

  // Öyrənilmiş hərflər
  static Future<Set<String>> getLearned() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_learnedKey) ?? [];
    return list.toSet();
  }

  static Future<void> markLearned(String letter) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_learnedKey) ?? [];
    if (!list.contains(letter)) {
      list.add(letter);
      await prefs.setStringList(_learnedKey, list);
    }
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_learnedKey);
    await prefs.remove(_quizBestKey);
  }

  // Test rekord
  static Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_quizBestKey) ?? 0;
  }

  static Future<void> saveBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final best = prefs.getInt(_quizBestKey) ?? 0;
    if (score > best) {
      await prefs.setInt(_quizBestKey, score);
    }
  }
}
