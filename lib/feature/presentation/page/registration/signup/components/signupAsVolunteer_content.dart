import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/form/form.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/navigation.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:open_eye/feature/presentation/widget/genderChosse.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';
import 'package:open_eye/helper/helper.dart';
import 'package:http/http.dart' as http;

class SignUpFormAsVolunteer extends StatefulWidget {
  @override
  _SignUpFormAsVolunteerState createState() => _SignUpFormAsVolunteerState();
}

class _SignUpFormAsVolunteerState extends State<SignUpFormAsVolunteer> {
  final _formKey = GlobalKey<FormState>();
  bool? _isMale = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(text: '@gmail.com');
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _ageController.dispose();
    _hobbiesController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nationalIdController.dispose();
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
              controller: _nameController,
              obscureText: false,
              validation: true,
              validationEmail: false,
              validationPassword: false,
              keyboardType: TextInputType.text,
              validationErrorMsg: kNameNullError),
          SizedBox(
              height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Email',
              hintValue: kEmailNullError,
              maxLines: 1,
              controller: _emailController,
              obscureText: false,
              validation: true,
              validationEmail: true,
              validationPassword: false,
              keyboardType: TextInputType.emailAddress,
              validationErrorMsg: kEmailNullError),
          SizedBox(
              height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Phone number',
              controller: _phoneNumberController,
              hintValue: kPhoneNumberNullError,
              maxLines: 1,
              obscureText: false,
              validation: true,
              validationEmail: false,
              validationPassword: false,
              keyboardType: TextInputType.number,
              validationErrorMsg: kPhoneNumberNullError),
          SizedBox(
              height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Age',
              controller: _ageController,
              hintValue: kAgeError,
              maxLines: 1,
              obscureText: false,
              validation: true,
              validationEmail: false,
              validationPassword: false,
              keyboardType: TextInputType.number,
              validationErrorMsg: kAgeError),
          SizedBox(
              height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Password',
              hintValue: kPassNullError,
              controller: _passwordController,
              maxLines: 1,
              obscureText: true,
              validation: true,
              validationEmail: false,
              validationPassword: true,
              keyboardType: TextInputType.visiblePassword,
              validationErrorMsg: kPassNullError),
          SizedBox(
              height: getProportionateScreenHeight(10)),
          EditTextField().getCustomEditTextArea(
              labelValue: 'Hobbies',
              controller: _hobbiesController,
              hintValue: kHobbiesNullError,
              maxLines: 4,
              obscureText: false,
              validation: true,
              validationEmail: false,
              validationPassword: false,
              keyboardType: TextInputType.text,
              validationErrorMsg: kHobbiesNullError),
          SizedBox(height: getProportionateScreenHeight(10)),
          CustomTextFormField(labelText: "National ID", controller: _nationalIdController,enabled: true,maxLines: 1,hintValue: kNationalIDNullError,),
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
                    setState((){_isMale = true;});
                  },
                  child: Gender(icon: Icons.male_rounded, text: 'Male', isSelected: _isMale! ? true : false)),
              InkWell(
                  onTap: (){
                    setState((){_isMale = false;});
                  },
                  child: Gender(icon: Icons.female_rounded, text: 'Female', isSelected: _isMale! ? false : true)),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          // DefaultButton(
          //     text: "Continue",
          //     press: () {
          //       if (_formKey.currentState!.validate()) {
          //         _formKey.currentState!.save();
          //         KeyboardUtil.hideKeyboard(context);
          //         Navigator.pushNamed(
          //             context, CustomNavigationBarScreen.routeName,
          //             arguments: false);
          //       }
          //     }
          //
          // ),
        ],
      ),
    );
  }
  Future senddata() async {
    Uri? url ;
    final response = await http.post(url!, body: {
      "name": _nameController.text,
      "email": _emailController.text,
      "phoneNumber":_phoneNumberController.text,
      "password":_passwordController.text,
      "age":_ageController.text,
      "hobbies":_hobbiesController.text,
      "nationalID":_nationalIdController.text,
      "gender": _isMale,
    });
  }
}