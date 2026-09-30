import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final FlutterTts _tts = FlutterTts();
  static bool _initialized = false;

  static Future<void> _init() async {
    if (_initialized) return;
    await _tts.setLanguage("ar-SA");
    await _tts.setSpeechRate(0.3);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _initialized = true;
  }

  static Future<void> speak(String text) async {
    await _init();
    await _tts.stop();
    await _tts.speak(text);
  }

  static Future<void> stop() async {
    await _tts.stop();
  }

  static Future<void> setArabicLanguage() async {
    await _tts.setLanguage("ar-SA");
  }
}
