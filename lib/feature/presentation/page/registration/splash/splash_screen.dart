
import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/registration/splash/components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}