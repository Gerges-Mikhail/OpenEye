import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/presentation/common/flutterTTS/flutterTTS.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/components/body.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/domain/auth%20help.dart';
import 'package:open_eye/feature/domain/auth.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/home/blind_home.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/components/blind_signin.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/components/signin_content.dart';
import 'package:open_eye/feature/presentation/common/form/form.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/navigation.dart';
import 'package:open_eye/feature/presentation/page/registration/forgetPassword/forgetPassword.dart';
import 'package:open_eye/feature/presentation/page/registration/signup/signup.dart';
import 'package:open_eye/feature/presentation/widget/avatarGlow.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:open_eye/feature/presentation/widget/noAccountText.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';
import 'package:open_eye/helper/helper.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FlutterTts flutterTts = FlutterTts();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSignIn =false;
  final _formKey = GlobalKey<FormState>();
  stt.SpeechToText? _speech;
  bool? _isBlind = true;
  String textFromFile = "";
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  final TextEditingController _emailController = TextEditingController(text: "@gmail.com");
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();
  final auth = Authe();
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _speak('hello, say one to set your email, say two to set your password, 3 if you forgot your password, 4 to go to home page, 5 if you do not have an account and say hello for inquiries.');
  }
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _wordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          _listen();
          getData();
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(18)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SignInContent(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomAvatarGlow(
                          isListening: _isListening,
                          press: () {
                            _listen();
                            getData();
                          },
                        ),
                        CustomUserKind(isBlind: _isBlind,pressOnblind: () => setState(()=> _isBlind = true),pressOnVolunteer: (){ Navigator.pushNamed(context, VolunteerForm.routeName);}),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        EditTextField().getCustomEditTextArea(
                            labelValue: 'Email',
                            hintValue: kEmailNullError,
                            controller: _emailController,
                            obscureText: false,
                            validation: true,
                            validationEmail: true,
                            validationPassword: false,
                            keyboardType: TextInputType.emailAddress,
                            validationErrorMsg: kEmailNullError),
                        SizedBox(height: getProportionateScreenHeight(15)),
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
                        SizedBox(height: getProportionateScreenHeight(15)),
                        Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ForgetPasswordScreen.routeName);
                              },
                              child: const Text(
                                "Forgot Password ?",
                              ),
                            )),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DefaultButton(
                            text: "Continue",
                            press: () async{
                              if(_formKey.currentState!.validate())
                              {
                                _formKey.currentState!.save();
                                try{
                                  // final authResult = await auth.signin(_emailController.text, _passwordController.text);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>  HomeBlind()),
                                  // );
                                  if(_emailController.text == ''){

                                  }
                                }on PlatformException catch(e){
                                  print(e.toString());
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text( e.message!,
                                    ),
                                  ),
                                  );
                                }
                              }

                              //   if (_formKey.currentState!.validate()) {
                              //     _formKey.currentState!.save();
                              //     senddata();
                              //     KeyboardUtil.hideKeyboard(context);
                              //     Navigator.pushNamed(
                              //         context, CustomNavigationBarScreen.routeName,
                              //         arguments: _isBlind);
                              //   }
                            }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const CustomSignInBottom(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const NoAccountText(),
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
    var url = "https://gradone.000webhostapp.com/api/blind/register";
    final response = await http.post(Uri.parse(url), body: {
      "email": _emailController.text.toString(),
      "password":_passwordController.text.toString(),
    });
    var res = await http.post(Uri.parse(url), body: jsonEncode({
      "email": _emailController.text.toString(),
      "password":_passwordController.text.toString(),
    }));
    var message = jsonDecode(res.body);
    if (message == "true") {
      print("Successful" + message);
    } else {
      print("Error: " + message);
    }
  }

  getData() {
    setState(() {
      textFromFile = _text;
      _wordController.text = textFromFile;
    });
  }
  setIsListeningTrue(){
    setState(()=> _isListening = true);
  }
  setIsListeningFalse(){
    setState(()=> _isListening = false);
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
  onResultDefault(var val){
    setState(() {
      _text = val.recognizedWords;
      getData();
      setIsListeningFalse();
      _speech!.stop();
      if(_wordController.text == 'hi' || _wordController.text == 'hello'){
        _speak('hello, say one to set your email, say two to set your password, 3 if you forgot your password, 4 to go to home page, 5 if you do not have an account and say hello for inquiries.');
      }else if(_wordController.text == "Home page"){
        Navigator.pushNamed(
            context, CustomNavigationBarScreen.routeName,
            arguments: _isBlind);
      }
      else{
        controllerNumber(int.parse(_wordController.text));
      }
    });
  }
  onResultEmail(var val){
    setState(
          () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _emailController.text =
          "${textFromFile.replaceAll(' ', '')}@gmail.com";
        });
      },
    );
  }
  onResultPassword(var val){
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
  void controllerNumber(int number) {
    if (number == 01) {
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultEmail(val)
      );
    }
    else if (number == 02) {
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultPassword(val)
      );
    }else if (number == 03) {
      Navigator.pushNamed(context, ForgetPasswordScreen.routeName,);
    }
    else if (number == 04) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        KeyboardUtil.hideKeyboard(context);
        Navigator.pushReplacementNamed(
            context, CustomNavigationBarScreen.routeName,
            arguments: _isBlind);
      }
    }
    else if (number.toInt() == 5) {
      Navigator.pushNamed(context, SignUpScreen.routeName,);
    }
    else {
      _speak("please , say a valid number.");
    }
  }

}