import 'package:firebase_auth/firebase_auth.dart';

class Authe{
  final _auth = FirebaseAuth.instance;

  Future signup(String email, String password)async{
    final authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return authResult;
  }

  Future signin(String email, String password)async{
    final authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }

}