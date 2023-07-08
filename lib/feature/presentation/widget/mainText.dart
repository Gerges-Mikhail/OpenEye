import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';

class MainText extends StatelessWidget {
  const MainText({
    Key? key,
    this.isBlind,
    this.name,
  }) : super(key: key);

  final bool? isBlind;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isBlind!?'Blind' : 'Volunteer',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(25),
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Text(
          name!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(25),
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),

      ],
    );
  }
}