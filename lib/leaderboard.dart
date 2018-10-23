import 'package:flutter/material.dart';
import 'package:concours/firestore_config.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  FirestoreConfig firestoreConfig;
  List data;

  @override
  initState(){
    super.initState();
    this.firestoreConfig = new FirestoreConfig("leaderboard");
    this.data = [];
    this.setup();
  }

  Future<void> setup() async {
    var querySnapshot = firestoreConfig.getSnapshot();

    querySnapshot.listen((snapshot){
      snapshot.documents.forEach((doc){
        setState((){
          this.data.add(doc.data);
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.data.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(
            "#${this.data[index]["rank"]} ${this.data[index]["college_name"]}"
          ),
        ),
      )
    );
  }
}