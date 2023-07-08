// import 'package:flutter/material.dart';
// import 'package:open_eye/feature/presentation/common/colors/colors.dart';
// import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
// import 'package:open_eye/feature/presentation/page/navigation_pages/components/navigationBlind_content.dart';
// import 'package:open_eye/feature/presentation/page/navigation_pages/components/navigationVolunteer_contact.dart';
//
// class BodyNavigationBar extends StatelessWidget {
//   final bool? args ;
//
//   BodyNavigationBar(this.args);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//           width: double.infinity,
//           child: Padding(
//             padding:
//                 EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: SizeConfig.screenHeight * 0.04),
//
//                 args!? Container() : Column(
//                   children: [
//                     SizedBox(height: getProportionateScreenHeight(20),),
//                     Row(
//                       children: [
//                         Flexible(
//                           child: Text(
//                             'Helping the needy is a source of happiness for the soul and heart.',
//                             style: TextStyle(
//                               color: grey,
//                               fontSize: getProportionateScreenWidth(20)
//                             ),
//                           ),
//                         ),
//                         Image.asset("assets/images/splash2.png",height: getProportionateScreenHeight(180),),
//                       ],
//                     ),
//                     SizedBox(height: getProportionateScreenHeight(30),),
//                   ],
//                 ),
//                 SizedBox(height: getProportionateScreenHeight(15),),
//                 args! ? NavigationListBlind() : NavigationListVolunteer(),
//               ],
//             ),
//           ),
//         ),
//     );
//   }
// }
