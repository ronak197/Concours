import 'package:flutter/material.dart';
import 'firestore_config.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List data;
  FirestoreConfig firestoreConfig;

  @override
  initState(){
    super.initState();
    firestoreConfig = new FirestoreConfig("teams");
    this.data = [];

    this.setup();
  }

  Future<void> setup() async {
    var querySnapshot = firestoreConfig.getSnapshot();

    querySnapshot.listen((snapshot){
      List docs = snapshot.documents;

      docs.sort((team1, team2){
        var ratio1 = (team1.data["wins"]/team1.data["match_count"]) * 100;
        var ratio2 = (team2.data["wins"]/team2.data["match_count"]) * 100;

        if(team1.data["match_count"] == 0){
          ratio1 = 0;
        }
        if(team2.data["match_count"] == 0){
          ratio2 = 0;
        }

        var r = ratio2.compareTo(ratio1);
        return r;
      });

      setState((){
        this.data = [];
      });

      docs.forEach((doc){
        doc.data["id"] = doc.documentID;
        this.data.add(doc.data);

        print(doc.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.data.length,
        itemBuilder: (BuildContext context, int index){
          return Text("#$index ${this.data[index]["team"]} ${this.data[index]["wins"]/this.data[index]["match_count"]}");
        },
      )
    );
  }
}