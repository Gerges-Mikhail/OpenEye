import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/signin.dart';
import 'package:open_eye/feature/presentation/page/registration/splash/components/splash_content.dart';
import 'package:open_eye/feature/presentation/widget/button/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  savePref(bool isLunch)async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    prf.setBool('isLunch', isLunch);
    print(prf.getBool("isLunch"));
  }
  getPref()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    var isLunch = prf.getBool('isLunch');
    if(isLunch != null){
      Navigator.pushNamed(context, SignInScreen.routeName);
    }
  }

  int currentPage = 0;
  bool? isFirstOne;
  List<Map<String, String>> splashData = [
    {
      "textMain": "OPEN EYE APPLICATION",
      "textHint": "As blind you will find help from the application here.",
      "image": "assets/images/splash1.png"
    },
    {
      "textMain": "Meet your Volunteer",
      "textHint": "Both the blind and the volunteer can join a video call with privacy conditions to help the blind.",
      "image": "assets/images/splash2.png"
    },
    {
      "textMain": "More Features",
      "textHint": "A blind can use features such as alarm, detect an object, color recognition, currencies recognition, textRecognition read books, record notes and  callByPhoneNumber.",
      "image": "assets/images/splash3.png"
    },
  ];
  @override
  void initState() {
    getPref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  textMain: splashData[index]['textMain'],
                  textHint: splashData[index]['textHint'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                        savePref(true);

                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? primaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}