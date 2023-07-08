import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/data/model/phoneNumberModel.dart';
import 'package:open_eye/feature/data/sqflite/sqflite.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/widget/avatarGlow.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:open_eye/feature/presentation/widget/mainText.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

class CallByPhoneNumberScreen extends StatefulWidget {
  static String routeName = "/callByPhone_screen";

  const CallByPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<CallByPhoneNumberScreen> createState() =>
      _CallByPhoneNumberScreenState();
}

class _CallByPhoneNumberScreenState extends State<CallByPhoneNumberScreen> {
  final TextEditingController _numberCtrl = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();
  List<PhoneNumberModel> datas = [];
  bool fetching = true;
  stt.SpeechToText? _speech;
  String _text = '';
  String textFromFile = "";
  bool _isListening = false;
  late MyDatabase db;
  FlutterTts flutterTts = FlutterTts();


  @override
  void dispose() {
    _numberCtrl.dispose();
    _wordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterTts.speak("you are in phone number page say hello for inquiries");
    db = MyDatabase();
    _numberCtrl.text = '';
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: (){
          Navigator.of(context).pop();
          flutterTts.stop();
        },
        onTap: () {
          _listen();
          getData();
        },
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(35),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: const MainText(
                        isBlind: true,
                        name: 'Leo Ryan',
                      )),
                  Container(
                    alignment: Alignment.center,
                    child: CustomAvatarGlow(
                      isListening: _isListening,
                      press: () {
                        _listen();
                        getData();
                      },
                    ),
                  ),
                  EditTextField().getCustomEditTextArea(
                    maxLength: 11,
                    validation: false,
                    validationEmail: false,
                    validationPassword: false,
                    labelValue: "Phone Number",
                    keyboardType: TextInputType.phone,
                    obscureText: false,
                    controller: _numberCtrl,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  DefaultButton(
                    text: 'Call',
                    press: () => call(_numberCtrl.text),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  const Text(
                    "To Save a contact",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  CustomTextFormField(
                    labelText: "Name",
                    controller: _nameController,
                    maxLines: 1,
                    hintValue: "name",
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  EditTextField().getCustomEditTextArea(
                    maxLength: 11,
                    validation: false,
                    validationEmail: false,
                    validationPassword: false,
                    labelValue: "Phone Number",
                    keyboardType: TextInputType.phone,
                    obscureText: false,
                    controller: _phoneNumberController,
                  ),
                   DefaultButton(
                    press: () {
                      insertPhoneNumber();
                      },
                    text: 'Add',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
  Future senddata() async {
    Uri? url ;
    final response = await http.post(url!, body: {
      "name": _nameController.text,
      "phoneNumber":_phoneNumberController.text,
    });
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
      if (_wordController.text == 'hi') {
        _speak(
            'you can say one to say phone number and two for calling him three to add number with name to your list, four to call number from your list');
      } else if (int.parse(_wordController.text) == 1) {
        getData();
        setIsListeningTrue();
        _speech!.listen(
            listenFor: const Duration(milliseconds: 25000),
            partialResults: false,
            onResult: (val) {
              setState(
                () {
                  _text = val.recognizedWords;
                  getData();
                  setIsListeningFalse();
                  _speech!.stop();
                  setState(() {
                    textFromFile = _text;
                    _numberCtrl.text = textFromFile.replaceAll(' ', '');
                  });
                },
              );
            });
      } else if (int.parse(_wordController.text) == 2) {
        if (_wordController.text.isEmpty) {
          _speak('please say one and say the number to call him');
        } else {
          call(_numberCtrl.text);
        }
      }
    });
  }

  getData() {
    setState(() {
      textFromFile = _text;
      _wordController.text = textFromFile;
    });
  }

  void insertPhoneNumber() {
    PhoneNumberModel dataLocal = PhoneNumberModel(
        name: _nameController.text, phoneNumber: _phoneNumberController.text);
    db.insertPhoneNumberData(dataLocal);
    dataLocal.id = datas[datas.length - 1].id! + 1;
    setState(() {
      datas.add(dataLocal);
    });
    _speak("contact saved successfully");
  }


  call(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
