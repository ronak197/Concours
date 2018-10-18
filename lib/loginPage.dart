import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DocumentReference documentReference = Firestore.instance.document("badminton/teams");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool signedIn = false;

  @override
  void initState(){
    super.initState();
    this._initScreen();
  }

  Future<bool> _initScreen() async {
    var _isSignedIn = await googleSignIn.isSignedIn();
    if(_isSignedIn){
      setState((){
        signedIn = true;
        
      });
    }
  }

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken
    );

    print("User Name: ${user.displayName}");
    bool isSignedIn = await googleSignIn.isSignedIn();

    setState((){
      signedIn = isSignedIn;
    });
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("./assets/concours_logo.png"),
            FlatButton(
              onPressed: () => _signIn()
                .then((FirebaseUser user) => print(user))
                .catchError((e) => print(e)),
              child: Image.asset(
                "./assets/google_sign_in.png",
                height: 50.0
              ),
              
            ),
          ]
        )
      )
    );
  }
}