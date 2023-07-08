import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';

class SignUserKind extends StatelessWidget {
  const SignUserKind({
    Key? key,
    required this.icon,
    required this.text, required this.isSelected,
  }) : super(key: key);

  final String icon;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.09,
      width: SizeConfig.screenWidth * 0.3,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected?  Colors.grey.shade200:primaryColor,
        ),
        color:isSelected? primaryColor : Colors.grey.shade200,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon,height:SizeConfig.screenHeight * 0.05,),
          SizedBox(height: SizeConfig.screenHeight * 0.002,),
          Text(text,style: TextStyle(fontSize: 18,color: isSelected? white : primaryColor ),)
        ],
      ),
    );
  }
}
