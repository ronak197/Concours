import 'package:flutter/material.dart';
import 'package:concours/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("./assets/concours_logo.png"),
            FlatButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()
                ),
                (Route<dynamic> route) => false
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Continue ",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.redAccent
                    )
                  ),
                  Icon(Icons.navigate_next)
                ]
              )
            ),
          ]
        )
      )
    );
  }
}