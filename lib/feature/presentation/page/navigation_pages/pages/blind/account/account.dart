import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/flutterTTS/flutterTTS.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/widget/avatarGlow.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/accountDataCard.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BlindAccountScreen extends StatefulWidget {
  const BlindAccountScreen({Key? key}) : super(key: key);

  @override
  State<BlindAccountScreen> createState() => _BlindAccountScreenState();
}

class _BlindAccountScreenState extends State<BlindAccountScreen> {
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
  }

  List<String> titles = ['Name', 'Phone Number', 'Email', 'Password', 'Age'];
  List<IconData> icons = [
    Icons.person_sharp,
    Icons.phone,
    Icons.alternate_email,
    Icons.password,
    Icons.numbers,
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            _listen();
          },
          onDoubleTap: () {
            Navigator.of(context).pop;
          },
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Text(
                    "Profile :",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(25)),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CircleAvatar(
                                  radius: 22.2,
                                  backgroundColor: white,
                                  child: Icon(
                                    Icons.person_sharp,
                                    size: 120,
                                    color: grey,
                                  ))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: primaryColor),
                            child: const Icon(
                              Icons.edit_sharp,
                              color: white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AccountCard(
                    title: titles[0],
                    iconData: icons[0],
                  ),
                  AccountCard(
                    title: titles[1],
                    iconData: icons[1],
                  ),
                  AccountCard(
                    title: titles[2],
                    iconData: icons[2],
                  ),
                  AccountCard(
                    title: titles[3],
                    iconData: icons[3],
                  ),
                  AccountCard(
                    title: titles[4],
                    iconData: icons[4],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(56),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                        ),
                        primary: primaryColor,
                        backgroundColor: white,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: CustomAvatarGlow(
          isListening: _isListening,
          press: () {},
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
            if (_wordController.text == "hi" ||
                _wordController.text == "hello") {
              _speak(
                  'Hello, you can say number one to join with a volunteer, number two to set the alarm, three to detect an object, four to color recognition, five to the textRecognition, six to personal notes, seven to currencies recognition, or eight to call by phone number.');
            } else {
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
    } else if (number == 02) {
    } else if (number == 03) {
    } else if (number == 04) {
    } else if (number == 05) {
    } else if (number == 06) {
    } else if (number == 07) {
    } else if (number == 08) {
    } else if (number == 09) {
    } else {
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
