import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:concours/firestore_config.dart';
import 'package:concours/start_game.dart';

class AdminScoreboardPage extends StatefulWidget {
  @override
  _AdminScoreboardPageState createState() => _AdminScoreboardPageState();
}

class _AdminScoreboardPageState extends State<AdminScoreboardPage> {
  List data;
  List inputFields;
  final formatter = new DateFormat('HH:mm, d MMM');

  @override
  void initState(){
    super.initState();

    this.data = [];
    this.inputFields = [];
    this.setup();
  }

  Future<void> setup() async {
    FirestoreConfig firestoreConfig;
    firestoreConfig = new FirestoreConfig("schedule");
    var querySnapshot = firestoreConfig.getSnapshot();
    
    querySnapshot.listen((snapshot){
      List docs = snapshot.documents;

      docs.sort((match1, match2){
        var r = match1.data["timestamp"].compareTo(match2.data["timestamp"]);
        return r;
      });

      setState((){
        this.data = [];
      });

      docs.forEach((doc){
        doc.data["id"] = doc.documentID;
        if(doc.data["live"] == null){
          doc.data["live"] = false;
        }

        var matchTime = DateTime.parse(doc.data["timestamp"].toString());

        if(matchTime.isBefore(DateTime.now())){
          setState((){
            this.data.add(doc.data);
          });
        }
      });
    });
  }

  Future<String> _start(Map match, String matchType) async {
    if(match["type"] == null || !match["type"].contains(matchType)){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StartGameScaffold(match, matchType)
        )
      );
    }
    return "success";
  }

  Future<String> _pause(Map match) async {
    FirestoreConfig firestoreConfig;
    firestoreConfig = new FirestoreConfig("live");

    match["draft"] = true;

    await firestoreConfig.addData(match["id"], match);
    return "success";
  }

  Future<String> _end(Map match, String matchType) async {
    match["live"] = false;

    FirestoreConfig firestoreConfig;
    firestoreConfig = new FirestoreConfig("ended");
    firestoreConfig.addData(match["id"] + matchType, match);

    firestoreConfig = new FirestoreConfig("live");
    await firestoreConfig.deleteData(match["id"] + matchType);

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.data.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Column(
              children: <Widget>[
                Text("${this.data[index]["id"]}"),
                Column(
                  children: <Widget>[
                    Text(formatter.format(this.data[index]["timestamp"])),
                    Text("${this.data[index]["participants"][0]["college"]}"),
                    Text(" VS "),
                    Text("${this.data[index]["participants"][1]["college"]}"),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("1S")
                        ),
                        RaisedButton(
                          child: Icon(Icons.stop),
                          onPressed: () => _end(this.data[index], "1S"),
                        ),
                        RaisedButton(
                          child: Icon(Icons.play_arrow),
                          onPressed: () => _start(this.data[index], "1S"),
                        ),
                      ]
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("1D")
                        ),
                        RaisedButton(
                          child: Icon(Icons.stop),
                          onPressed: () => _end(this.data[index], "1D"),
                        ),
                        RaisedButton(
                          child: Icon(Icons.play_arrow),
                          onPressed: () => _start(this.data[index], "1D"),
                        ),
                      ]
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("2S")
                        ),
                        RaisedButton(
                          child: Icon(Icons.stop),
                          onPressed: () => _end(this.data[index], "2S"),
                        ),
                        RaisedButton(
                          child: Icon(Icons.play_arrow),
                          onPressed: () => _start(this.data[index], "2S"),
                        ),
                      ]
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("2D")
                        ),
                        RaisedButton(
                          child: Icon(Icons.stop),
                          onPressed: () => _end(this.data[index], "2D"),
                        ),
                        RaisedButton(
                          child: Icon(Icons.play_arrow),
                          onPressed: () => _start(this.data[index], "2D"),
                        ),
                      ]
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("3S")
                        ),
                        RaisedButton(
                          child: Icon(Icons.stop),
                          onPressed: () => _end(this.data[index], "3S"),
                        ),
                        RaisedButton(
                          child: Icon(Icons.play_arrow),
                          onPressed: () => _start(this.data[index], "3S"),
                        ),
                      ]
                    )
                  ]
                )
              ]
            )
          );
        },
      )
    );
  }
}