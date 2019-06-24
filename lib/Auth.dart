import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> currentUser();
  void signOut();
}
class Auth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future<String> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.uid;
  }

    void signOut()  {
     _firebaseAuth.signOut();
     googleSignIn.signOut();

  }



}