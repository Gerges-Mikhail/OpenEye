import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/form/form.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:open_eye/feature/presentation/widget/genderChosse.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';
import 'package:open_eye/helper/helper.dart';

class SignUpFormAsBilnd extends StatefulWidget {
  const SignUpFormAsBilnd({Key? key}) : super(key: key);

  @override
  _SignUpFormAsBilndState createState() => _SignUpFormAsBilndState();
}

class _SignUpFormAsBilndState extends State<SignUpFormAsBilnd> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  bool isMale = true;
  @override
  void dispose() {
    cEmail.dispose();
    cPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EditTextField().getCustomEditTextArea(
              labelValue: 'Name',
              hintValue: kNameNullError,
              maxLines: 1,
              obscureText: false,
              validation: true,
              keyboardType: TextInputType.text,
              validationErrorMsg: kNameNullError),
          SizedBox(height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Email',
              hintValue: kEmailNullError,
              maxLines: 1,
              controller: cEmail,
              obscureText: false,
              validation: true,
              validationEmail: true,
              keyboardType: TextInputType.emailAddress,
              validationErrorMsg: kEmailNullError),
          SizedBox(height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Phone number',
              hintValue: kPhoneNumberNullError,
              maxLines: 1,
              obscureText: false,
              validation: true,
              validationEmail: false,
              keyboardType: TextInputType.number,
              validationErrorMsg: kPhoneNumberNullError),
          SizedBox(height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Age',
              hintValue: kAgeError,
              maxLines: 1,
              obscureText: false,
              validation: true,
              validationEmail: true,
              keyboardType: TextInputType.number,
              validationErrorMsg: kAgeError),
          SizedBox(height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Password',
              hintValue: kPassNullError,
              controller: cPassword,
              maxLines: 1,
              obscureText: true,
              validation: true,
              validationEmail: false,
              validationPassword: true,
              keyboardType: TextInputType.visiblePassword,
              validationErrorMsg: kPassNullError),
          SizedBox(height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Hobbies',
              hintValue: kHobbiesNullError,
              maxLines: 4,
              obscureText: false,
              validation: true,
              validationEmail: true,
              keyboardType: TextInputType.text,
              validationErrorMsg: kHobbiesNullError),
          SizedBox(height: getProportionateScreenHeight(10)),
          Container(
            alignment: Alignment.centerLeft,
              child: Text(
                  'Gender : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(20),
                ),
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  setState((){isMale = true;});
                },
                  child: Gender(icon: Icons.male_rounded, text: 'Male', isSelected: isMale ? true : false)),
              InkWell(
                  onTap: (){
                    setState((){isMale = false;});
                  },
                  child: Gender(icon: Icons.female_rounded, text: 'Female', isSelected: isMale ? false : true)),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                }
              }

          ),
        ],
      ),
    );
  }
}