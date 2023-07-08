import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/data/model/phoneNumberModel.dart';
import 'package:open_eye/feature/data/sqflite/sqflite.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/flutterTTS/flutterTTS.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/widget/avatarGlow.dart';
import 'package:open_eye/feature/presentation/widget/phoneNumberCard.dart';
import 'package:open_eye/feature/presentation/widget/mainText.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BlindFavListScreen extends StatefulWidget {
  const BlindFavListScreen({Key? key}) : super(key: key);
  static String routeName = "/favList_screen";
  @override
  State<BlindFavListScreen> createState() => _BlindFavListScreenState();
}

class _BlindFavListScreenState extends State<BlindFavListScreen> {
  FlutterTts flutterTts =FlutterTts();
  stt.SpeechToText? _speech;
  bool? _isListening = false;
  String _text = 'Press the button and start speaking';
  String? textFromFile;
  final TextEditingController _wordController = TextEditingController();
  List<PhoneNumberModel> datas = [];
  bool fetching = true;
  late MyDatabase db;

  @override
  void dispose() {
    super.dispose();
    _wordController.dispose();
  }

  @override
  void initState() {
    _speak("favourite list opened, say hello for inquiries or list for telling your list");
    db = MyDatabase();
    _speech = stt.SpeechToText();
    getNumbersData();
    super.initState();
  }
  void getNumbersData() async {
    datas = await db.getPhoneNumberData();
    setState(() {
      fetching = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: GestureDetector(
        onTap: (){
          _listen();
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenHeight(50)),
                const MainText(
                  isBlind: true,
                  name: 'Leo Ryan',
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Favourite List',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(25),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                fetching
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Flexible(
                  child: ListView.builder(
                      itemCount: datas.length,
                      itemBuilder: (context, i) {
                        return (i > 0 || i == 0)?
                        PhoneNumberCard(data: datas[i], index: i)
                            : Container();
                      }),
                ),
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
              _speak( 'Hello');
            }else if(_wordController.text == "list"){
              _speak("your list is : ${datas[0].name}");
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
    if (number == 00) {
      Navigator.of(context).pop();
    } else if (number == 01) {
      call(datas[0].phoneNumber);
    } else if (number == 02) {
    } else if (number == 03) {
    } else if (number == 04) {
    } else if (number == 05) {
    } else if (number == 06) {
    } else if (number == 07) {
    } else if (number == 08) {
    }
    else {
      _speak('Please, say a valid number.');
      _wordController.text = 'Please, say a valid number.';
    }
  }
  call(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }
  void deletePhoneNumber(int index) {
    db.deleteNotesData(datas[index].id!);
    setState(() {
      datas.removeAt(index);
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

