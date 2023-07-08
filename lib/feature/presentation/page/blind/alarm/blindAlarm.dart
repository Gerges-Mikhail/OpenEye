import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);
  static String routeName = "/alarm_screen";

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlarmScreen'),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Center(
        child: Text('body'),
      ),
    );
  }
}
