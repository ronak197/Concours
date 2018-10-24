import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concours/home.dart';
import 'package:concours/user_config.dart';
import 'package:concours/firestore_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DocumentReference documentReference = Firestore.instance.document("badminton/teams");
  FirestoreConfig firestoreConfig;

  UserConfig userConfig;



  Future<String> _signIn() async {
    UserConfig userConfig = new UserConfig();
    firestoreConfig = new FirestoreConfig("users");

    await userConfig.signIn();

    bool _isSignedIn = await userConfig.isLoggedIn();
    Map userData = await userConfig.getUser();

    Map<String, dynamic> data = {
      "name": userData['displayName'],
      "email": userData['email'],
    };

    firestoreConfig.addData(userData["uid"], data);

    if(_isSignedIn){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage()
        ),
        (Route<dynamic> route) => false
      );
    }

    return "Success";
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
              onPressed: () => _signIn(),
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