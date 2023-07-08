import 'package:flutter_tts/flutter_tts.dart';

class ff{
  FlutterTts flutterTts = FlutterTts();

  Future _speak(String text) async {
    await flutterTts.setLanguage("en_US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.speak(text);
  }

  Future _stop() async {
    await flutterTts.stop();
  }

}

