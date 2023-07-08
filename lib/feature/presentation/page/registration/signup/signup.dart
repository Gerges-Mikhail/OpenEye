import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/presentation/common/flutterTTS/flutterTTS.dart';
import 'package:open_eye/feature/presentation/page/registration/signup/components/body.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
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
}