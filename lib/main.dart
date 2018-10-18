import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final DocumentReference documentReference = Firestore.instance.document("badminton/teams");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken
    );

    print("User Name: ${user.displayName}");
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print("User Sign Out");
  }

  void _add(){
    Map<String, dynamic> data = <String, dynamic>{
      "Teams": [
        {
          "Team Name": "Cocktail",
          "Players": [
            {
              "Name": "Sanket",
              "Age": "18"
            },
            {
              "Name": "Ronak",
              "Age": "20"
            }
          ]
        },
        {
          "Team Name": "Safarjan",
          "Players": [
            {
              "Name": "Hello",
              "Age": "21"
            }
          ]
        },
      ]
    };

    documentReference.setData(data)
      .whenComplete((){
        print("Document Added");
      })
      .catchError((e) => print(e));
  }

  void _delete(){
    documentReference.delete()
      .whenComplete((){
        print("Document Deltede");

      })
      .catchError((e) => print(e));
  }

  void _update(){
    Map<String, String> data = <String, String>{
      "Name": "Sanket",
    };

    documentReference.updateData(data)
      .whenComplete((){
        print("Document Updated");
      })
      .catchError((e) => print(e));
  }

  void _fetch(){
    documentReference.get()
      .then((datasnapshot){
        if(datasnapshot.exists){
          print(datasnapshot.data["Name"]);
        }
      })
      .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Concours")
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _signIn()
                .then((FirebaseUser user) => print(user))
                .catchError((e) => print(e)),
              child: Text("Sign In"),
              color: Colors.green
            ),
            Padding(
              padding: const EdgeInsets.all(10.0)
            ),
            RaisedButton(
              onPressed: () => _signOut(),
              child: Text("Sign Out"),
              color: Colors.red
            ),
            Padding(
              padding: const EdgeInsets.all(10.0)
            ),
            RaisedButton(
              onPressed: _add,
              child: Text("Add"),
              color: Colors.cyan
            ),
            Padding(
              padding: const EdgeInsets.all(10.0)
            ),
            RaisedButton(
              onPressed: _update,
              child: Text("Update"),
              color: Colors.lightBlue
            ),
            Padding(
              padding: const EdgeInsets.all(10.0)
            ),
            RaisedButton(
              onPressed: _delete,
              child: Text("Delete"),
              color: Colors.orange
            ),
            Padding(
              padding: const EdgeInsets.all(10.0)
            ),
            RaisedButton(
              onPressed: _fetch,
              child: Text("Fetch"),
              color: Colors.lime
            )
          ]
        )
      )
    );
  }
}