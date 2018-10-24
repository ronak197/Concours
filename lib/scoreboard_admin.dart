import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:concours/firestore_config.dart';

class AdminScoreboardPage extends StatefulWidget {
  @override
  _AdminScoreboardPageState createState() => _AdminScoreboardPageState();
}

class _AdminScoreboardPageState extends State<AdminScoreboardPage> {
  List data;
  final formatter = new DateFormat('HH:mm, d MMM');

  @override
  void initState(){
    super.initState();
    
    this.data = [];
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
        var matchTime = DateTime.parse(doc.data["timestamp"].toString());

        if(matchTime.isBefore(DateTime.now())){
          setState((){
            this.data.add(doc.data);
          });
        }
      });
    });
  }

  Future<String> _start(Map match) async {
    FirestoreConfig firestoreConfig;
    firestoreConfig = new FirestoreConfig("live");
    match["participants"][0]["score"] = 0;
    match["participants"][1]["score"] = 0;
    
    match["draft"] = false;
    match["live"] = true;
    match["result"] = "";

    await firestoreConfig.addData(match["id"], match);
    return "success";
  }

  Future<String> _pause(Map match) async {
    FirestoreConfig firestoreConfig;
    firestoreConfig = new FirestoreConfig("live");

    match["draft"] = true;

    await firestoreConfig.addData(match["id"], match);
    return "success";
  }

  Future<String> _end(Map match) async {
    FirestoreConfig firestoreConfig;
    firestoreConfig = new FirestoreConfig("live");

    match["live"] = false;

    await firestoreConfig.addData(match["id"], match);
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
                        RaisedButton(
                          child: Text(
                            "Start",
                          ),
                          onPressed: () => _start(this.data[index]),
                        ),
                        RaisedButton(
                          child: Text(
                            "Pause"
                          ),
                          onPressed: () => _pause(this.data[index])
                        ),
                        RaisedButton(
                          child: Text(
                            "End"
                          ),
                          onPressed: () => _end(this.data[index]),
                        )
                      ],
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