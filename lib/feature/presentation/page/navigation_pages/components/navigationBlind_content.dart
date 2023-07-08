import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/widget/button/features_btn.dart';

class HomeListBlind extends StatelessWidget {
  const HomeListBlind({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeaturesButton(
                  text: 'Join With a volunteer',
                  image: "assets/images/feature1.png",
                  // press: () => Navigator.pushNamed(
                  //     context, VolunteerCallScreen.routeName),
                ),
                FeaturesButton(
                  text: 'Personal \nalarm',
                  image: "assets/images/feature2.png",
                  // press: () =>
                  //     Navigator.pushNamed(context, AlarmScreen.routeName),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeaturesButton(
                  text: 'Detect an object',
                  image: "assets/images/feature3.png",
                  // press: () => Navigator.pushNamed(
                  //     context, DetectObjectScreen.routeName),
                ),
                FeaturesButton(
                  text: 'Color recognition',
                  image: "assets/images/feature4.png",
                //   press: () =>
                //       Navigator.pushNamed(context, ColorScreen.routeName),
                 ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeaturesButton(
                  text: 'Text in picture',
                  image: "assets/images/feature5.png",
                  // press: () =>
                  //     Navigator.pushNamed(context, LibraryScreen.routeName),
                ),
                FeaturesButton(
                  text: 'Personal notes',
                  image: "assets/images/feature6.png",
                  // press: () =>
                  //     Navigator.pushNamed(context, NotesScreen.routeName),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeaturesButton(
                  text: 'Currencies recognition',
                  image: "assets/images/feature7.png",
                  // press: () => Navigator.pushNamed(
                  //     context, CurrenciesScreen.routeName),
                ),
                FeaturesButton(
                  text: 'Call by phone number',
                  image: "assets/images/feature8.png",
                  // press: () => Navigator.pushNamed(
                  //     context, CallByPhoneNumberScreen.routeName),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
          ],
        ),
      ),
    );
  }
}
