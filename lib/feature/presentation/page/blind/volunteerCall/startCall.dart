import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/flutterTTS/flutterTTS.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/blind/volunteerCall/AudioCallScreen.dart';
import 'package:open_eye/feature/presentation/widget/avatarGlow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'Video Call Screen.dart';

class VolunteerCallScreen extends StatefulWidget {
  const VolunteerCallScreen({Key? key}) : super(key: key);
  static String routeName = "/volunteerCall_screen";
  @override
  _VolunteerCallScreenState createState() => _VolunteerCallScreenState();
}

class _VolunteerCallScreenState extends State<VolunteerCallScreen> {
  FlutterTts flutterTts = FlutterTts();

  final TextEditingController _wordController = TextEditingController();
  stt.SpeechToText? _speech;
  String _text = '';
  String textFromFile = "";
  bool _isListening = false;
  @override
  void initState() {
    super.initState();
    _speak("you are in start video call page say hello for inquiries");
    _speech = stt.SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).pop();
        _speak("you are in home screen say hello for inquiries");
      },
      onTap: () {
        _listen();
        getData();
      },
      child: Scaffold(
        backgroundColor: white,
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomAvatarGlow(
                  isListening: _isListening,
                  press: () {
                    _listen();
                    getData();
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Icon(
                          Icons.video_call,
                          size: getProportionateScreenWidth(45),
                         color: primaryColor,
                        ),
                      Icon(
                        Icons.phone,
                        size: getProportionateScreenWidth(45),
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setIsListeningTrue();
        _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) {
            onResultDefault(val);
          },
        );
      }
    } else {
      setIsListeningFalse();
      _speech!.stop();
    }
  }

  setIsListeningTrue() {
    setState(() => _isListening = true);
  }

  setIsListeningFalse() {
    setState(() => _isListening = false);
  }

  onResultDefault(var val) {
    setState(() {
      _text = val.recognizedWords;
      getData();
      setIsListeningFalse();
      _speech!.stop();
      if (_wordController.text == 'hello') {
        _speak(
            'you can say zero one to start a video call with a volunteer and zero two to start a voice call with a volunteer');
      } else if (int.parse(_wordController.text) == 01) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => VideoCallScreen()));
      } else if (int.parse(_wordController.text) == 02) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AudioCallScreen()));
      } else {
        _speak('please say one and say one or two to call a volunteer');
      }
    });
  }

  getData() {
    setState(() {
      textFromFile = _text;
      _wordController.text = textFromFile;
    });
  }
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
