import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/form/form.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/registration/resetPassword/restPassword.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';
import 'package:open_eye/helper/helper.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child:Column(
          children: [
            EditTextField().getCustomEditTextArea(
                labelValue: 'Email',
                hintValue: kEmailNullError,
                obscureText: false,
                validation: true,
                validationEmail: true,
                validationPassword: false,
                keyboardType: TextInputType.emailAddress,
                validationErrorMsg: kEmailNullError),
            SizedBox(height: getProportionateScreenHeight(30)),
            DefaultButton(
                text: "Continue",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    KeyboardUtil.hideKeyboard(context);
                    Navigator.pushNamed(context, ResetPasswordScreen.routeName);
                  }
                }
            ),
          ],
        ),
    );
  }
}
