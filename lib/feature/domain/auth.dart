import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/page/navigation_pages/pages/blind/home/blind_home.dart';
import 'package:open_eye/feature/presentation/page/registration/signin/signin.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot){
          if(snapshot.hasData){
            return HomeBlind();
          }else{
            return SignInScreen();
          }
        }),
      ),
    );
  }
}

