import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/signin.dart';
import 'package:open_eye/feature/presentation/page/registration/signup/signup.dart';

class haveAccountText extends StatelessWidget {
  const haveAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account ?",
          style: TextStyle(
              color: black,
              fontSize: getProportionateScreenWidth(16)

          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
          child: Text(
            "Sign In",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(16),
                color: primaryColor),
          ),
        ),
      ],
    );
  }
}
