import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_eye/feature/domain/auth.dart';
import 'package:open_eye/feature/presentation/common/theme/theme.dart';
import 'package:open_eye/feature/presentation/page/registration/splash/splash_screen.dart';
import 'package:open_eye/feature/presentation/route/route.dart';
List<CameraDescription>? cameras;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp( MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Eye',
      theme: theme(),
      routes: routes,
      home: Auth(),
    );
  }
}
