import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/page/registration/forgetPassword/components/body.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/forget_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyForgetPassword(),
    );
  }
}