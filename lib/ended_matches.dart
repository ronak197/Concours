import 'package:flutter/material.dart';
import 'package:concours/firestore_config.dart';

class EndedMatchesScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ended")
      ),
      body: EndedMatchesPage()
    );
  }
}

class EndedMatchesPage extends StatefulWidget {
  @override
  _EndedMatchesPageState createState() => _EndedMatchesPageState();
}

class _EndedMatchesPageState extends State<EndedMatchesPage> {
  FirestoreConfig firestoreConfig;
  List data;

  @override
  initState(){
    super.initState();
    this.data = [];
    this.firestoreConfig = new FirestoreConfig("live");

    this.setup();
  }

  Future<void> setup() async {
    Stream querySnapshot = firestoreConfig.getSnapshot();

    querySnapshot.listen((snapshot){
      List docs = snapshot.documents;

      setState((){
        this.data = [];
        docs.forEach((doc){
          doc.data["id"] = doc.documentID;
          if(!doc.data["live"]){
            this.data.add(doc.data);
          }
        });
      });
    });
  }

  Future<void> _revive(Map match) async {
    firestoreConfig.addData(match["id"], match);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.data.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Row(
            children: <Widget> [
              Text(this.data[index]["id"]),
              IconButton(
                icon: Icon(Icons.cached),
                onPressed: (){
                  _revive(this.data[index]);
                },
              )
            ]
          )
        );
      }
    );
  }
}