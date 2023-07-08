import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/account/account.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/favList/favList.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/home/blind_home.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/settings/settings.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/volunteer/account/account.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/volunteer/home/volunteer_home.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/volunteer/notification/notification.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/volunteer/settings/settings.dart';

class CustomNavigationBarScreen extends StatefulWidget {
  static String routeName = "/navigation_bar";

  @override
  State<CustomNavigationBarScreen> createState() =>
      _CustomNavigationBarScreenState();
}

class _CustomNavigationBarScreenState extends State<CustomNavigationBarScreen> {
  int pageIndex = 0;

  final blindPages = [
    const HomeBlind(),
    const BlindFavListScreen(),
    const BlindSettingsScreen(),
    const BlindAccountScreen(),
  ];

  final volunteerPages = [
    const VolunteerHomeScreen(),
    const VolunteerNotificationScreen(),
    const VolunteerSettingsScreen(),
    const VolunteerAccountScreen(),
  ];

  final blindIcons = [
    Icon(
      Icons.home,
      color: Colors.white,
      size: getProportionateScreenWidth(30),
    ),
    Icon(
      Icons.menu,
      color: Colors.white,
      size: getProportionateScreenWidth(30),
    ),
    Icon(
      Icons.settings,
      color: Colors.white,
      size: getProportionateScreenWidth(30),
    ),
    Icon(
      Icons.account_circle,
      color: Colors.white,
      size: getProportionateScreenWidth(30),
    ),
  ];
  final volunteerIcons = [
    Icon(
      Icons.home,
      color: Colors.white,
      size: getProportionateScreenWidth(30),
    ),
    Icon(
      Icons.notifications,
      color: Colors.white,
      size: getProportionateScreenWidth(30),
    ),
    Icon(
      Icons.settings,
      color: Colors.white,
      size: getProportionateScreenWidth(30),
    ),
    Icon(
      Icons.account_circle,
      color: Colors.white,
      size: getProportionateScreenWidth(30),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final userKind = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      extendBody: true,
      body: userKind ? blindPages[pageIndex] : volunteerPages[pageIndex],
      bottomNavigationBar: userKind
          ? CurvedNavigationBar(
              height: getProportionateScreenHeight(55),
              buttonBackgroundColor: primaryColor,
              backgroundColor: Colors.transparent,
              color: primaryColor,
              index: pageIndex,
              onTap: (pageIndex) => setState(() => this.pageIndex = pageIndex),
              items: blindIcons,
            )
          : CurvedNavigationBar(
              height: getProportionateScreenHeight(55),
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: primaryColor,
              color: primaryColor,
              index: pageIndex,
              onTap: (pageIndex) => setState(() => this.pageIndex = pageIndex),
              items: volunteerIcons,
            ),
    );
  }
}
