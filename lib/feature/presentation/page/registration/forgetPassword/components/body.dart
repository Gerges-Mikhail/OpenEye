import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/form/form.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/registration/forgetPassword/components/forgetPassword_content.dart';

class BodyForgetPassword extends StatelessWidget {
  const BodyForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot",
                      style: TextStyle(
                        color: black,
                        fontSize: getProportionateScreenWidth(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: getProportionateScreenWidth(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Container(
                  alignment: Alignment.center,
                    child: Image.asset("assets/images/forgetPassword1.png")),
                SizedBox(height: getProportionateScreenHeight(20)),
                ForgetPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
