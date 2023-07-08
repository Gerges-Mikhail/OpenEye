import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/home/blind_home.dart';
import 'package:open_eye/feature/presentation/widget/mainText.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlindSettingsScreen extends StatefulWidget {
  const BlindSettingsScreen({Key? key}) : super(key: key);

  @override
  State<BlindSettingsScreen> createState() => _BlindSettingsScreenState();
}

class _BlindSettingsScreenState extends State<BlindSettingsScreen> {
  int value = 0;
  bool endCall = false;
  bool cameraFlash = false;
  bool notifications = false;
  bool autoVoice = false;
  bool loading = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSettingVlaues();
}
  getSettingVlaues()async{
    SharedPreferences shp = await SharedPreferences.getInstance();
    setState((){
      autoVoice = shp.getBool('autoVoice')!;
      print('successful save auto voice value');
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                MainText(isBlind: true,name: 'Leo Ryan',),
                SizedBox(height: getProportionateScreenHeight(10),),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(25),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10),),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(right: getProportionateScreenWidth(5),left: getProportionateScreenWidth(5)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(50.0),topRight: Radius.circular(50.0)),
                      color: Colors.grey.shade300,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10),vertical: getProportionateScreenHeight(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'End Call : ',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(18),
                                    fontWeight: FontWeight.bold,
                                    color: black
                                  ),
                                ),
                              ),
                              AnimatedToggleSwitch<bool>.dual(
                                current: endCall,
                                first: false,
                                second: true,
                                loading: false,
                                dif: 50.0,
                                borderColor: Colors.transparent,
                                borderWidth: 6.0,
                                height: getProportionateScreenHeight(60),
                                boxShadow: const [
                                  BoxShadow(
                                    color: grey,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1.5),
                                  ),
                                ],
                                onChanged: (b) {
                                  setState(() => endCall = b);
                                  return Future.delayed(Duration(seconds: 1));
                                },
                                colorBuilder: (b) => b ? primaryColor : primaryColor,
                                iconBuilder: (value) => value
                                    ? Icon(Icons.arrow_forward,color: white,)
                                    : Icon(Icons.arrow_back,color: white,),
                                textBuilder: (value) => value
                                    ? Center(child: Text('Double Click on screen'))
                                    : Center(child: Text('Double click on power button')),
                              ),
                              SizedBox(height: getProportionateScreenHeight(10),),
                              Container(color: primaryColor,width: double.infinity,height: getProportionateScreenHeight(1),),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Camera flash access :',
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      fontWeight: FontWeight.bold,
                                      color: black
                                  ),
                                ),
                              ),
                              AnimatedToggleSwitch<bool>.dual(
                                current: cameraFlash,
                                first: false,
                                second: true,
                                loading: false,
                                dif: 50.0,
                                borderColor: Colors.transparent,
                                borderWidth: 6.0,
                                height: getProportionateScreenHeight(60),
                                boxShadow: const [
                                  BoxShadow(
                                    color: grey,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1.5),
                                  ),
                                ],
                                onChanged: (b) {
                                  setState(() => cameraFlash = b);
                                  return Future.delayed(Duration(seconds: 1));
                                },
                                colorBuilder: (b) => b ? Colors.green : red,
                                iconBuilder: (value) => value
                                    ? Icon(Icons.person_add,color: white,)
                                    : Icon(Icons.person_add_disabled,color: white,),
                                textBuilder: (value) => value
                                    ? Center(child: Text('Volunteer'))
                                    : Center(child: Text('only me')),
                              ),
                              SizedBox(height: getProportionateScreenHeight(10),),
                              Container(color: primaryColor,width: double.infinity,height: getProportionateScreenHeight(1),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Send a notification when the volunteer is available : ',
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      fontWeight: FontWeight.bold,
                                      color: black
                                  ),
                                ),
                              ),
                              AnimatedToggleSwitch<bool>.dual(
                                current: notifications,
                                first: false,
                                second: true,
                                loading: false,
                                dif: 50.0,
                                borderColor: Colors.transparent,
                                borderWidth: 5.0,
                                height: 55,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1.5),
                                  ),
                                ],
                                onChanged: (b) {
                                  setState(() => notifications = b);
                                  return Future.delayed(Duration(seconds: 1));
                                },
                                colorBuilder: (b) => b ? Colors.green : Colors.red,
                                iconBuilder: (value) => value
                                    ? Icon(Icons.send,color: white,)
                                    : Icon(Icons.block,color:white),
                                textBuilder: (value) => value
                                    ? Center(child: Text('Allow'))
                                      : Center(child: Text('Block')),
                              ),
                              SizedBox(height: getProportionateScreenHeight(10),),
                              Container(color: primaryColor,width: double.infinity,height: getProportionateScreenHeight(1),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Auto voice',
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      fontWeight: FontWeight.bold,
                                      color: black
                                  ),
                                ),
                              ),
                              AnimatedToggleSwitch<bool>.dual(
                                current: autoVoice,
                                first: false,
                                second: true,
                                loading: false,
                                dif: 50.0,
                                borderColor: Colors.transparent,
                                borderWidth: 5.0,
                                height: 55,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1.5),
                                  ),
                                ],
                                onChanged: (voiceValue) async{
                                  SharedPreferences shp = await SharedPreferences.getInstance();
                                  shp.setBool('autoVoice', voiceValue);
                                  setState(() => autoVoice = voiceValue);
                                   Future.delayed(Duration(seconds: 1));
                                },
                                colorBuilder: (b) => b ? Colors.green : Colors.red,
                                iconBuilder: (value) => value
                                    ? Icon(Icons.done,color: white,)
                                    : Icon(Icons.block,color: white,),
                                textBuilder: (value) => value
                                    ? Center(child: Text('Allow'))
                                    : Center(child: Text('Block')),
                              ),
                              SizedBox(height: getProportionateScreenHeight(10),),
                              Container(color: primaryColor,width: double.infinity,height: getProportionateScreenHeight(1),),
                            ],
                          ),
                        ],
                      ),
                    ),
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
