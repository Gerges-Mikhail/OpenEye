import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/registration/forgetPassword/forgetPassword.dart';
import 'package:open_eye/feature/presentation/page/volunteer/blindCall/joinToBlind.dart';
import 'package:open_eye/feature/presentation/widget/button/features_btn.dart';
import 'package:open_eye/feature/presentation/widget/mainText.dart';

class VolunteerHomeScreen extends StatefulWidget {
  const VolunteerHomeScreen({Key? key}) : super(key: key);

  @override
  State<VolunteerHomeScreen> createState() => _VolunteerHomeScreenState();
}

class _VolunteerHomeScreenState extends State<VolunteerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                MainText(
                  isBlind: false,
                  name: 'John Snow',
                ),
                Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Helping the needy is a source of happiness for the soul and heart.',
                            style: TextStyle(
                                color: grey,
                                fontSize: getProportionateScreenWidth(20)),
                          ),
                        ),
                        Image.asset(
                          "assets/images/splash2.png",
                          height: getProportionateScreenHeight(180),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                  ],
                ),
                FeaturesButton(
                  press: (){
                    Navigator.pushNamed(
                        context, JoinToBlind.routeName);
                  },
                  text: 'Join with a blind',
                  image: 'assets/images/feature1.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
