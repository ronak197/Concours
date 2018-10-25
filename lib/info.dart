import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0
      ),
      color: Colors.white,
      margin: EdgeInsets.all(5.0),
      child: ListView(
        children: <Widget>[
          Image.asset("./assets/concours_logo.png"),
          Text("Concours 2018 will be the 10th national level sports fest of " +
            "Dhirubhai Ambani Institute of Information and " +
            "Communication Technology, Gandhinagar. Scheduled from " +
            "25th-28th October Concours’18 has competition in 9 major " +
            "sport events alongside a large bunch of fun events.",
            style: TextStyle(
              fontSize: 20.0
            )
          )
        ],
      ),
    );
  }
}