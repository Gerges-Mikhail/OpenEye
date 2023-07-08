import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
  );
}
TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: black),
    bodyText2: TextStyle(color: primaryColor),
  );
}
