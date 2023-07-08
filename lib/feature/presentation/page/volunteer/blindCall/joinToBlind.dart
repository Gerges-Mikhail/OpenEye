import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/blind/textRecognition/textRecognition.dart';
import 'package:open_eye/feature/presentation/page/volunteer/blindCall/videoCallScreenBlind.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';

class JoinToBlind extends StatefulWidget {
  static String routeName = "/joinBlind_screen";
  const JoinToBlind({Key? key}) : super(key: key);

  @override
  State<JoinToBlind> createState() => _JoinToBlindState();
}

class _JoinToBlindState extends State<JoinToBlind> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isClicked = false;
  List<String> tokens = [
    "007eJxTYDg67fCMmujfgSbxSr9jN93N88v9KmG9dMaSwpSHrFNjJgspMBgnpRqmmJgnGSSlGZtYpFlYpJoZJZsap5mlJRkbmhonX1GOSmkIZGRYp3GWiZEBAkF8Nob01KL01GIGBgDQsSDS",
    "mikhail",
    "mesbah",
  ];
  List<String> id = [
    "3be1d47b0bf348f88e62c53f6fb3153c",
    "2",
    "3",
  ];
  List<String> name = [
    "gerges",
    "mikhail",
    "mesbah",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          leading: IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_sharp,color: primaryColor,)),
            title: const Text(
              'Join to a bilnd',
              style: TextStyle(color: primaryColor),
            ),
            centerTitle: true,
            backgroundColor: white,
            elevation: 0.0,
          actions: [
            IconButton(onPressed: (){_showAlertDialog();}, icon: const Icon(Icons.info,color: primaryColor,)),
          ],
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                  labelText: 'ID',
                  controller: _idController,
                  enabled: false,
                  hintValue: '',
                  maxLines: 1),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              CustomTextFormField(
                  labelText: 'Token',
                  controller: _tokenController,
                  enabled: false,
                  hintValue: '',
                  maxLines: 1),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              CustomTextFormField(
                  labelText: 'Name',
                  controller: _nameController,
                  enabled: false,
                  hintValue: '',
                  maxLines: 1),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              DefaultButton(
                  text: "Get information",
                  press: () {
                    setState(() {
                      _idController.text = id[0];
                      _tokenController.text = tokens[0];
                      _nameController.text = name[0];
                      _isClicked = !_isClicked;
                    });
                  }),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              _isClicked ?  DefaultButton(text: "Join",press:()=>Navigator.pushNamed(context, VideoCallScreenV.routeName),) : Container(),
            ],
          ),
        ));
  }
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('What should you do ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('''
                Please,tap on "Get Information" buttonto get information from api,then you can join with a blind in video call.''',overflow: TextOverflow.visible,textAlign: TextAlign.start,),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
