import 'package:flutter/material.dart';

class BadmintonDetails extends StatefulWidget {
  @override
  _BadmintonDetailsState createState() => _BadmintonDetailsState();
}

class _BadmintonDetailsState extends State<BadmintonDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0),
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Center(
                  child: Text("India", style: TextStyle(color: Colors.red, fontSize: 20.0),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 10.0,
                child: Center(child: Text("vs", style: TextStyle(fontSize: 12.0),)),
              ),
              Flexible(
                  child: Center(
                    child: Text("Australia", style: TextStyle(color: Colors.red, fontSize: 20.0),),
                  )
              )
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: 7.0),
          ),
          Text("Semi-Finals", style: TextStyle(fontSize: 13.0, color: Colors.grey),),
          Padding(
            padding: EdgeInsets.only(top: 7.0),
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("3", style: TextStyle(color: Colors.red, fontSize: 28.0),),
                      Text("Sania Nehwal", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
                    ],
                  ),
                ),
              ),
              Text("-", style: TextStyle(fontSize: 16.0),),
              Flexible(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("4", style: TextStyle(color: Colors.red, fontSize: 28.0),),
                        Text("Moris", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
                      ],
                    ),
                  )
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
