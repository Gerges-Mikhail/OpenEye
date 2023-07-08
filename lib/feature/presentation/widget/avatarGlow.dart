import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';

class CustomAvatarGlow extends StatelessWidget {
   bool? isListening = false;
   Function? press;
   CustomAvatarGlow({Key? key, this.isListening,this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      animate: isListening!,
      glowColor: primaryColor,
      endRadius: 75.0,
      duration: const Duration(milliseconds: 2000),
      repeatPauseDuration: const Duration(milliseconds: 100),
      repeat: true
      ,
      child: FloatingActionButton(
        backgroundColor: primaryColor,
        splashColor: grey,
        onPressed: press as void Function()?,
        //     (){
        //   _listen();
        //   getData();
        // },
        child: Icon(isListening! ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}
