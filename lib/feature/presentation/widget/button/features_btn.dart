import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';

class FeaturesButton extends StatelessWidget {
   FeaturesButton({
    Key? key,
    this.text,
    this.image,
    this.press,
  }) : super(key: key);
  final String? text;
  final String? image;
  final Function? press;
  Color color = Colors.grey ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(150),
      height: getProportionateScreenHeight(150),
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(primaryColor),
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: primaryColor)
                )
            )
        ),
        onPressed: press as void Function()?,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5), vertical: getProportionateScreenHeight(10)),
          child: Column(
            children: [
              Text(
                text!,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(15),),
              Image.asset(
                image!,
                scale: getProportionateScreenWidth(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}