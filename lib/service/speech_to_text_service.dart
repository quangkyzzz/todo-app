import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  SpeechToTextService();
  static SpeechToText speechToText = SpeechToText();
  static Future<bool> initSpeech() async {
    return speechToText.initialize();
  }

  static void startListen(Function(SpeechRecognitionResult) onResult) async {
    await speechToText.listen(
      onResult: onResult,
    );
  }

  static stopListen() async {
    await speechToText.stop();
  }
}
