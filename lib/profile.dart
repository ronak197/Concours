import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red.shade100,
            child: Icon(
              Icons.person,
              color: Colors.red.shade300,
              size: 40.0
            ),
            radius: 40.0,
          ),
          Text("Sanket Chaudhari"),
          Text("chaudharisanket2000@gmail.com")
        ]
      )
    );
  }
}