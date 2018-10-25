import 'dart:async';
import 'package:flutter/material.dart';
import 'package:concours/firestore_config.dart';

class StartGameScaffold extends StatelessWidget {
  final Map match;
  final String matchType;

  StartGameScaffold(this.match, this.matchType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Team")
      ),
      body: StartGamePage(match, matchType),
    );
  }
}

class StartGamePage extends StatefulWidget {
  String matchType;
  Map match;

  StartGamePage(this.match, this.matchType);

  @override
  StartGamePageState createState() {
    return new StartGamePageState();
  }
}

class StartGamePageState extends State<StartGamePage> {
  final team1player = TextEditingController();
  final team2player = TextEditingController();

  @override
  void dispose(){
    super.dispose();

    team1player.dispose();
    team2player.dispose();
  }

  Future<void> _play() async {
    FirestoreConfig firestoreConfig;
    firestoreConfig = new FirestoreConfig("schedule");
    List temp = [];
    

    if(widget.match["type"] != null){
      widget.match["type"].forEach((type){
        temp.add(type);
      });
    }

    temp.add(widget.matchType);
    widget.match["type"] = temp;

    await firestoreConfig.addData(widget.match["id"], widget.match);

    firestoreConfig = new FirestoreConfig("live");
    widget.match["participants"][0]["score"] = 0;
    widget.match["participants"][0]["name"] = team1player.text;
    
    widget.match["participants"][1]["score"] = 0;
    widget.match["participants"][1]["name"] = team2player.text;

    widget.match["draft"] = false;
    widget.match["live"] = true;
    widget.match["result"] = "";
    widget.match["type"] = widget.matchType;
    widget.match["id"] = widget.match["id"] + widget.matchType;

    await firestoreConfig.addData(widget.match["id"] + widget.matchType, widget.match);
  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: team1player,
            decoration: InputDecoration(
              hintText: "Team Player 1",
            ),
          ),
          TextFormField(
            controller: team2player,
            decoration: InputDecoration(
              hintText: "Team Player 2"
            )
          ),
          RaisedButton(
            child: Text("Play"),
            onPressed: () async {
              await _play();
              Navigator.pop(context);
            }
          )
        ],
      )      
    );
  }
}