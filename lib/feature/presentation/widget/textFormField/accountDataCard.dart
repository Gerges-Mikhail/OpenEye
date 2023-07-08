import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';

class AccountCard extends StatelessWidget {
   AccountCard({
    Key? key,
    required this.title,
    required this.iconData,
  }) : super(key: key);
  String title;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: primaryColor.withOpacity(.2),
            child:Icon(Icons.person_sharp,color: primaryColor,)),
        title:
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
              ),
            ),

        trailing: CircleAvatar(
          radius: 15,
          backgroundColor: grey.withOpacity(.2),
            child: Icon(Icons.arrow_forward_ios,color: grey,size: 15,)),
      ),
    );
  }
}
