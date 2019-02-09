import 'package:flutter/material.dart';

class VolleyballDetails extends StatefulWidget {
  @override
  _VolleyballDetailsState createState() => _VolleyballDetailsState();
}

class _VolleyballDetailsState extends State<VolleyballDetails> {
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
                  child: Text("DA-IICT", style: TextStyle(color: Colors.red, fontSize: 20.0),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 10.0,
                child: Center(child: Text("vs", style: TextStyle(fontSize: 12.0),)),
              ),
              Flexible(
                  child: Center(
                    child: Text("PDPU", style: TextStyle(color: Colors.red, fontSize: 20.0),),
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
                      Text("Sanket Chaudhari", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
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
                        Text("Not Sanket Chaudhari", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
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
