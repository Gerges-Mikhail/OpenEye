import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.textMain,
    this.textHint,
    this.image,
  }) : super(key: key);
  final String? textMain, textHint, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20)),
          child: Text(
            textMain!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(36),
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Spacer(flex: 2),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(300),
          width: getProportionateScreenWidth(250),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20)),
          child: Text(
            textHint!,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: grey,
            ),
          ),
        ),
      ],
    );
  }
}
