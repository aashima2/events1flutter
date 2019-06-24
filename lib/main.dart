import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'myEvents.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'Auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String uid = '';
  Auth service = new Auth();

  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  bool visible = true;

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    FirebaseUser firebaseUser =
        await firebaseauth.signInWithCredential(credential);
    Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .snapshots()
        .listen((snapshots) {
      if (!snapshots.exists) {
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          'uid': firebaseUser.uid,
          'email': firebaseUser.email,
          'photoURL': firebaseUser.photoUrl,
          'displayName': firebaseUser.displayName,
        });
      }
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => myEvents()));

  }

  @override
  void initState() {
    service.currentUser().then((uid) {
      if (uid != null) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => myEvents()));
      }
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: InkWell(
                    onTap: () {},
                    child: Stack(
                      children: <Widget>[
                            Container(
                              child: Visibility(
                                visible: visible,
                                child: GoogleSignInButton(
                                darkMode: true,
                                onPressed: () {
                                  setState(() {
                                    visible = false;
                                  });
                                  _signIn();
                                }),
                              ),
                            ),
                         Container(
                           child: Visibility(
                             visible: !visible,
                               child: CircularProgressIndicator()
                           ),
                         )
                          ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
