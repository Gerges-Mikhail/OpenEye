import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';

class Gender extends StatelessWidget {
  const Gender({
    Key? key,
    required this.icon,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(60),
      width: getProportionateScreenWidth(100),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected?  Colors.grey.shade200:primaryColor,
        ),
        color:isSelected? primaryColor : Colors.grey.shade200,
        borderRadius: BorderRadius.all(Radius.circular(getProportionateScreenWidth(50))),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,size: getProportionateScreenHeight(25),color: isSelected?white:primaryColor,),
          SizedBox(height: SizeConfig.screenHeight * 0.002,),
          Text(text,style: TextStyle(fontSize: 18,color: isSelected? white : primaryColor ),)
        ],
      ),
    );
  }
}
