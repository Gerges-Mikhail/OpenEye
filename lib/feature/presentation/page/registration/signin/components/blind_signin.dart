import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/form/form.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/navigation.dart';
import 'package:open_eye/feature/presentation/page/registration/forgetPassword/forgetPassword.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/components/signin_content.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:open_eye/feature/presentation/widget/noAccountText.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';
import 'package:open_eye/helper/helper.dart';

class VolunteerForm extends StatefulWidget{
  static String routeName = "/volunteer_form";

  @override
  State<VolunteerForm> createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {

  final _formKey = GlobalKey<FormState>();

  bool? _isBlind = true;

  String textFromFile = "";

  final TextEditingController _cEmail =
      TextEditingController(text: "@gmail.com");

  final TextEditingController _cPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _cEmail.dispose();
    _cPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      width: double.infinity,
      child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15),vertical: getProportionateScreenHeight(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SignInContent(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
                    height: getProportionateScreenHeight(200),
                    child: Image.asset('assets/images/splash2.png',),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  EditTextField().getCustomEditTextArea(
                      labelValue: 'Email',
                      hintValue: kEmailNullError,
                      controller: _cEmail,
                      obscureText: false,
                      validation: true,
                      validationEmail: true,
                      validationPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      validationErrorMsg: kEmailNullError),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  EditTextField().getCustomEditTextArea(
                      labelValue: 'Password',
                      hintValue: kPassNullError,
                      controller: _cPassword,
                      maxLines: 1,
                      obscureText: true,
                      validation: true,
                      validationEmail: false,
                      validationPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      validationErrorMsg: kPassNullError),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ForgetPasswordScreen.routeName);
                        },
                        child: const Text(
                          "Forgot Password ?",
                        ),
                      )),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DefaultButton(
                      text: "Continue",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          KeyboardUtil.hideKeyboard(context);
                          Navigator.pushNamed(
                              context, CustomNavigationBarScreen.routeName,
                              arguments: _isBlind = false);
                        }
                      }),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const CustomSignInBottom(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const NoAccountText(),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    ),
    );
  }
}
