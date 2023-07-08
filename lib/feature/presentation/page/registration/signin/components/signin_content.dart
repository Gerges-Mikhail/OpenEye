import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/widget/noAccountText.dart';
import 'package:open_eye/feature/presentation/widget/signupUserKind.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        Row(
          children: [
            Text(
              "Sign",
              style: TextStyle(
                color: black,
                fontSize: getProportionateScreenWidth(40),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: SizeConfig.screenHeight * 0.009),
            Text(
              "In",
              style: TextStyle(
                color: primaryColor,
                fontSize: getProportionateScreenWidth(40),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Text(
          "Hello, \nWelcome Back!",
          style: TextStyle(
            color: grey,
            fontSize: getProportionateScreenWidth(18),
          ),
        ),
      ],
    );
  }
}
class CustomUserKind extends StatelessWidget {
  final bool? isBlind;
  final Function? pressOnblind;
  final Function? pressOnVolunteer;
  const CustomUserKind({Key? key,this.isBlind, this.pressOnblind, this.pressOnVolunteer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: pressOnblind as void Function(),
            child: SignUserKind(
              isSelected: isBlind! ? true : false,
              icon: 'assets/icons/blind.png',
              text: 'Blind',
            )),
        GestureDetector(
            onTap: pressOnVolunteer as void Function(),
            child: SignUserKind(
              isSelected: isBlind! ? false : true,
              icon: 'assets/icons/support.png',
              text: 'Volunteer',
            )),
      ],
    );
  }
}
class CustomSignInBottom extends StatelessWidget {
  const CustomSignInBottom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              color: primaryColor,
              height: SizeConfig.screenHeight * 0.002,
              width: SizeConfig.screenWidth * 0.33,
            ),
            const Spacer(),
            const Text(
              'or',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Container(
              color: primaryColor,
              height: SizeConfig.screenHeight * 0.002,
              width: SizeConfig.screenWidth * 0.33,
            ),
          ],
        ),
      ],
    );
  }
}

class CustomTextSignUpScreen extends StatelessWidget {
  const CustomTextSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          children: [
            Text(
              "Sign",
              style: TextStyle(
                color: black,
                fontSize: getProportionateScreenWidth(40),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(3)),
            Text(
              "Up",
              style: TextStyle(
                color: primaryColor,
                fontSize: getProportionateScreenWidth(40),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
        Text(
          "Create an account",
          style: TextStyle(
            color: grey,
            fontSize: getProportionateScreenWidth(18),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(5)),
      ],
    );
  }
}
