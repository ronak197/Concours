import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: ListView(
        children: <Widget>[
          Text(
            "Developers",
            style: TextStyle(
              fontWeight: FontWeight.bold
            )
          ),
          ListTile(
            title: Text("Ronak Jain (@ronak197)")
          ),
          ListTile(
            title: Text("Sanket Chaudhari (@sanket143)")
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text("Be a contributor:"),
                Text("https://github.com/da-shed/Concours")
              ]
            )
          )

        ],
      )
    );
  }
}
