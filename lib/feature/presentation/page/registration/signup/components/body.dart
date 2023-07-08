import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/form/form.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/navigation.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/components/signin_content.dart';
import 'package:open_eye/feature/presentation/page/registration/signup/components/signupAsVolunteer_content.dart';
import 'package:open_eye/feature/presentation/widget/avatarGlow.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:open_eye/feature/presentation/widget/genderChosse.dart';
import 'package:open_eye/feature/presentation/widget/haveAccountText.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';
import 'package:open_eye/helper/helper.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText? _speech;
  bool? isBlind = true;
  bool _isMale = true;
  bool _isListening = false;
  String textFromFile = "";
  String _text = 'Press the button and start speaking';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(text: '@gmail.com');
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _phoneNumberController.dispose();
    _hobbiesController.dispose();
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          _listen();
          getData();
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextSignUpScreen(),
                  CustomUserKind(
                    isBlind: isBlind,
                    pressOnblind: () => setState(() => isBlind = true),
                    pressOnVolunteer: () => setState(() => isBlind = false),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  isBlind!
                      ? Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              Align(
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
                                  labelValue: 'Name',
                                  hintValue: kNameNullError,
                                  maxLines: 1,
                                  controller: _nameController,
                                  obscureText: false,
                                  validation: true,
                                  validationEmail: false,
                                  validationPassword: false,
                                  keyboardType: TextInputType.text,
                                  validationErrorMsg: kNameNullError),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              EditTextField().getCustomEditTextArea(
                                  labelValue: 'Email',
                                  hintValue: kEmailNullError,
                                  maxLines: 1,
                                  controller: _emailController,
                                  obscureText: false,
                                  validation: true,
                                  validationEmail: true,
                                  validationPassword: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validationErrorMsg: kEmailNullError),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              EditTextField().getCustomEditTextArea(
                                  labelValue: 'Phone number',
                                  controller: _phoneNumberController,
                                  hintValue: kPhoneNumberNullError,
                                  maxLines: 1,
                                  obscureText: false,
                                  validation: true,
                                  validationEmail: false,
                                  validationPassword: false,
                                  keyboardType: TextInputType.number,
                                  validationErrorMsg: kPhoneNumberNullError),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              EditTextField().getCustomEditTextArea(
                                  labelValue: 'Age',
                                  controller: _ageController,
                                  hintValue: kAgeError,
                                  maxLines: 1,
                                  obscureText: false,
                                  validation: true,
                                  validationEmail: false,
                                  validationPassword: false,
                                  keyboardType: TextInputType.number,
                                  validationErrorMsg: kAgeError),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              EditTextField().getCustomEditTextArea(
                                  labelValue: 'Password',
                                  hintValue: kPassNullError,
                                  controller: _passwordController,
                                  maxLines: 1,
                                  obscureText: true,
                                  validation: true,
                                  validationEmail: false,
                                  validationPassword: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  validationErrorMsg: kPassNullError),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              EditTextField().getCustomEditTextArea(
                                  labelValue: 'Hobbies',
                                  controller: _hobbiesController,
                                  hintValue: kHobbiesNullError,
                                  maxLines: 4,
                                  obscureText: false,
                                  validation: true,
                                  validationEmail: false,
                                  validationPassword: false,
                                  keyboardType: TextInputType.text,
                                  validationErrorMsg: kHobbiesNullError),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Gender : ',
                                  style: TextStyle(
                                    color: black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(20),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isMale = true;
                                        });
                                      },
                                      child: Gender(
                                          icon: Icons.male_rounded,
                                          text: 'Male',
                                          isSelected: _isMale ? true : false)),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isMale = false;
                                        });
                                      },
                                      child: Gender(
                                          icon: Icons.female_rounded,
                                          text: 'Female',
                                          isSelected: _isMale ? false : true)),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SignUpFormAsVolunteer(),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  DefaultButton(
                    text: "Continue",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                      }
                      KeyboardUtil.hideKeyboard(context);
                      Navigator.pushNamed(
                          context, CustomNavigationBarScreen.routeName,
                          arguments: isBlind);
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  const CustomSignInBottom(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  const haveAccountText(),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Future<List?> senddata() async {
  //   var url = "https://gradone.000webhostapp.com/api/blind/register";
  //   final response = await http.post(Uri.parse(url), body: {
  //     "name":"gerges",
  //     "email": "gerges@gmail.com",
  //     "phone":"01111618689",
  //     "age":"21",
  //     "hobbies":"football",
  //     "password" : "gergesghggd",
  //     "confirm_password":"gergesghggd",
  //   });
  //   var datauser = json.decode(response.body);
  //   print(datauser);
  // }

  getData() {
    setState(() {
      textFromFile = _text;
      _wordController.text = textFromFile;
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
          listenFor: const Duration(seconds: 10000),
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
      if (_wordController.text == 'hello' || _wordController.text == 'hi') {
        _speak(
            '''
        say zero one to enter your name ,
        zero two to email,
        zero three to your phone number,
        zero four to your age, zero five to password,
        zero six to your hobbies,
        zero seven to your gender,
        zero eight to go to home page,
        zero nine to go to sign in screen 
        and say hello for inquiries 
        ''');
      } else {
        controllerNumber(int.parse(_wordController.text));
      }
    });
  }

  onResultEmail(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _emailController.text = "${textFromFile.replaceAll(' ', '')}@gmail.com";
        });
      },
    );
  }

  onResultName(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _nameController.text = textFromFile.replaceAll(' ', '');
        });
      },
    );
  }

  onResultPhoneNumber(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _phoneNumberController.text = textFromFile.replaceAll(' ', '');
        });
      },
    );
  }

  onResultAge(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _ageController.text = textFromFile.replaceAll(' ', '');
        });
      },
    );
  }

  onResultHobbies(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _hobbiesController.text = textFromFile;
        });
      },
    );
  }

  onResultPassword(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _passwordController.text = textFromFile.replaceAll(' ', '');
        });
      },
    );
  }

  onResultGender(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        if (_wordController.text == 'yes') {
          setState(() {
            _isMale = true;
          });
        } else if (_wordController.text == 'no') {
          setState(() {
            _isMale = false;
          });
        } else {
          _speak("Please, Say yes or no");
        }
      },
    );
  }

  void controllerNumber(int number) {
    if (number == 01) { //onResultName
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultName(val));
    } else if (number == 02) { //onResultEmail
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultEmail(val));
    } else if (number == 03) { //onResultPhoneNumber
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultPhoneNumber(val));
    } else if (number == 04) { //onResultAge
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultAge(val));
    } else if (number == 05) { //onResultPassword
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultPassword(val));
    } else if (number == 6) { //onResultHobbies
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultHobbies(val));
    } else if (number == 07) { //onResultGender
      _speak("Are you male ?");
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultGender(val));
    } else if (number == 08) { //goTOHomeScreen
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        KeyboardUtil.hideKeyboard(context);
        Navigator.pushNamed(context, CustomNavigationBarScreen.routeName,
            arguments: isBlind);
      }
    } else {
      _speak("please, say a valid number.");
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
