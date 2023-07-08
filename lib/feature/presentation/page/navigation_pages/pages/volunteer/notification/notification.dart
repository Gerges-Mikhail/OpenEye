import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/widget/mainText.dart';

class VolunteerNotificationScreen extends StatefulWidget {
  const VolunteerNotificationScreen({Key? key}) : super(key: key);

  @override
  State<VolunteerNotificationScreen> createState() => _VolunteerNotificationScreenState();
}

class _VolunteerNotificationScreenState extends State<VolunteerNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                MainText(isBlind: false,name: 'John Snow',),
                Text("Volunteer Notification Screen"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
