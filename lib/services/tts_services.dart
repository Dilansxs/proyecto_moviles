import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _tts = FlutterTts();
  
  // Constructor y ajustes del motor de voz (idioma español, velocidad, volumen).
  TTSService() {
    _initTTS();
  }

  Future<void> _initTTS() async {
    await _tts.setLanguage("es-ES");
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  // Funciones públicas para reproducir texto o detener el audio en curso.
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}