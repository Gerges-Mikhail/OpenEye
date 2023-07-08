import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/presentation/common/flutterTTS/flutterTTS.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/blind/alarm/blindAlarm.dart';
import 'package:open_eye/feature/presentation/page/blind/blindNotes/blindNotes.dart';
import 'package:open_eye/feature/presentation/page/blind/callByPhoneNumber/call%20by%20phone%20number.dart';
import 'package:open_eye/feature/presentation/page/blind/colorRecognition/color_screen.dart';
import 'package:open_eye/feature/presentation/page/blind/currenciesRecognition/currenciesRecognition.dart';
import 'package:open_eye/feature/presentation/page/blind/detectAnObject/detectObject.dart';
import 'package:open_eye/feature/presentation/page/blind/textRecognition/textRecognition.dart';
import 'package:open_eye/feature/presentation/page/blind/volunteerCall/startCall.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/components/navigationBlind_content.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/favList/favList.dart';
import 'package:open_eye/feature/presentation/widget/avatarGlow.dart';
import 'package:open_eye/feature/presentation/widget/mainText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeBlind extends StatefulWidget {
  static String routeName = "/homeBlind_screen";
  const HomeBlind({Key? key}) : super(key: key);
  @override
  State<HomeBlind> createState() => _HomeBlindState();
}

class _HomeBlindState extends State<HomeBlind> {
  final user = FirebaseAuth.instance.currentUser!;
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText? _speech;
  bool? _isListening = false;
  String _text = 'Press the button and start speaking';
  String? textFromFile;
  final TextEditingController _wordController = TextEditingController();
  late bool autoVoice;
  @override
  void dispose() {
    super.dispose();
    _wordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    getSettingValues();
  }

  getSettingValues() async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    setState(() {
      autoVoice = shp.getBool('autoVoice')!;
      print('successful save auto voice value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            if (autoVoice == true) {
              _speak(
                  'Hello, you can say number one to join with a volunteer, number two to set the alarm, three to detect an object, four to color recognition, five to the textRecognition, six to personal notes, seven to currencies recognition, or eight to call by phone number.');
              _listen();
              getData();
            } else {
              _listen();
              getData();
            }
            _listen();
            getData();
          },
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  MainText(
                    isBlind: true,
                    name: '',
                  ),
                  TextField(
                    onTap: () {
                      setState(() {
                        textFromFile;
                      });
                    },
                    onChanged: (value) => setState(() => textFromFile = value),
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                    controller: _wordController,
                    enabled: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  const HomeListBlind(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: CustomAvatarGlow(
          isListening: _isListening,
          press: () {
            _listen();
            getData();
          },
        ),
      ),
    );
  }

  getData() {
    setState(() {
      textFromFile = _text;
      _wordController.text = textFromFile!;
    });
  }

  void _listen() async {
    if (!_isListening!) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            getData();
            setState(() => _isListening = false);
            _speech!.stop();
            if(_wordController.text == "hi" || _wordController.text == "hello" )
              {
                _speak( 'Hello, you can say number one to join with a volunteer, number two to set the alarm, three to detect an object, four to color recognition, five to the textRecognition, six to personal notes, seven to currencies recognition, or eight to call by phone number.');
              }
            else{
              var num = int.parse(_wordController.text);
              pageNumber(num);
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }

  void pageNumber(int number) {
    if (number == 01) {
      Navigator.pushNamed(context, VolunteerCallScreen.routeName);
    } else if (number == 02) {
      Navigator.pushNamed(context, AlarmScreen.routeName);
    } else if (number == 03) {
      Navigator.pushNamed(context, DetectObjectScreen.routeName);
    } else if (number == 04) {
      Navigator.pushNamed(context, ColorScreen.routeName);
    } else if (number == 05) {
      Navigator.pushNamed(context, TextRecognition.routeName);
    } else if (number == 06) {
      Navigator.pushNamed(context, NotesScreen.routeName);
    } else if (number == 07) {
      Navigator.pushNamed(context, CurrenciesScreen.routeName);
    } else if (number == 08) {
      Navigator.pushNamed(context, CallByPhoneNumberScreen.routeName);
    } else if (number == 09) {
      Navigator.pushNamed(context, BlindFavListScreen.routeName);
    }
    else {
      _speak('Please, say number of page.');
      _wordController.text = 'Please, say number of page.';
    }
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
