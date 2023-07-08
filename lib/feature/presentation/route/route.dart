import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/page/blind/alarm/blindAlarm.dart';
import 'package:open_eye/feature/presentation/page/blind/blindNotes/blindNotes.dart';
import 'package:open_eye/feature/presentation/page/blind/callByPhoneNumber/call%20by%20phone%20number.dart';
import 'package:open_eye/feature/presentation/page/blind/colorRecognition/color_screen.dart';
import 'package:open_eye/feature/presentation/page/blind/currenciesRecognition/currenciesRecognition.dart';
import 'package:open_eye/feature/presentation/page/blind/detectAnObject/detectObject.dart';
import 'package:open_eye/feature/presentation/page/blind/textRecognition/textRecognition.dart';
import 'package:open_eye/feature/presentation/page/blind/volunteerCall/startCall.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/navigation.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/favList/favList.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/home/blind_home.dart';
import 'package:open_eye/feature/presentation/page/registration/forgetPassword/forgetPassword.dart';
import 'package:open_eye/feature/presentation/page/registration/resetPassword/restPassword.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/components/blind_signin.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/signin.dart';
import 'package:open_eye/feature/presentation/page/registration/signup/signup.dart';
import 'package:open_eye/feature/presentation/page/registration/splash/splash_screen.dart';
import 'package:open_eye/feature/presentation/page/volunteer/blindCall/joinToBlind.dart';
import 'package:open_eye/feature/presentation/page/volunteer/blindCall/videoCallScreenBlind.dart';
import 'package:path/path.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  //registration
  SignInScreen.routeName: (context) => SignInScreen(),
  VolunteerForm.routeName: (context) => VolunteerForm(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  //navigation bar screens
  CustomNavigationBarScreen.routeName: (context) => CustomNavigationBarScreen(),
  BlindFavListScreen.routeName: (context) => BlindFavListScreen(),
  //blind features
  HomeBlind.routeName: (context) => const HomeBlind(),
  CallByPhoneNumberScreen.routeName: (context) => CallByPhoneNumberScreen(),
  VolunteerCallScreen.routeName: (context) => const VolunteerCallScreen(),
  AlarmScreen.routeName: (context) => const AlarmScreen(),
  NotesScreen.routeName: (context) => const NotesScreen(),
  ColorScreen.routeName: (context) => const ColorScreen(),
  CurrenciesScreen.routeName: (context) =>  CurrenciesScreen(),
  DetectObjectScreen.routeName: (context) =>  DetectObjectScreen(),
  TextRecognition.routeName: (context) =>  TextRecognition(),
  //volunteer features
  JoinToBlind.routeName: (context) => JoinToBlind(),
  VideoCallScreenV.routeName:(context) => VideoCallScreenV(),
};