import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:concours/firestore_config.dart';

class LiveScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Page"),
      ),
      body: LivePage()
    );
  }
}

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  List data;
  FirestoreConfig firestoreConfig;
  

  final formatter = new DateFormat('HH:mm, d MMM');

  @override
  void initState(){
    super.initState();
    this.firestoreConfig = new FirestoreConfig("live");
    this.data = [];
    this.setup();
  }

  Future<void> setup() async {
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
        if(doc.data["live"]){
          setState((){
            this.data.add(doc.data);
          });
        }
      });
    });
  }

  Future<void> _plus1(Map data) async {
    data["participants"][0]["score"]++;
    this.firestoreConfig.addData(data["id"], data);
  }

  Future<void> _plus2(Map data) async {
    data["participants"][1]["score"]++;
    firestoreConfig.addData(data["id"], data);
  }

  Future<void> _minus1(Map data) async {
    data["participants"][0]["score"]--;
    firestoreConfig.addData(data["id"], data);
  }

  Future<void> _minus2(Map data) async {
    data["participants"][1]["score"]--;
    firestoreConfig.addData(data["id"], data);
  }

  Future<void> _wins(Map data, int teamNumber) async {
    data["result"] = data["participants"][teamNumber]["team"];
    
    data["live"] = false;
    firestoreConfig.addData(data["id"], data);

    firestoreConfig = new FirestoreConfig("ended");
    firestoreConfig.addData(data["id"], data);

    firestoreConfig = new FirestoreConfig("live");
    
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(formatter.format(this.data[index]["timestamp"])),
                    Text(
                      "${this.data[index]["participants"][0]["college"]}"
                      + " VS " +
                      "${this.data[index]["participants"][1]["college"]}"
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text(
                                  "${this.data[index]["participants"][0]["score"]}+",
                                ),
                                onPressed: () => _plus1(this.data[index]),
                              ),
                              RaisedButton(
                                child: Text(
                                  "-"
                                ),
                                onPressed: () => _minus1(this.data[index]),
                              ),
                              RaisedButton(
                                child: Text(
                                  "${this.data[index]["participants"][0]["team"]} WINS"
                                ),
                                onPressed: () => _wins(this.data[index], 0)
                              )
                            ]
                          )
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text(
                                  "${this.data[index]["participants"][1]["score"]}+",
                                ),
                                onPressed: () => _plus2(this.data[index])
                              ),
                              RaisedButton(
                                child: Text(
                                  "-"
                                ),
                                onPressed: () => _minus2(this.data[index]),
                              ),
                              RaisedButton(
                                child: Text(
                                  "${this.data[index]["participants"][1]["team"]} WINS"
                                ),
                                onPressed: () => _wins(this.data[index], 1)
                              )
                            ]
                          ),
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