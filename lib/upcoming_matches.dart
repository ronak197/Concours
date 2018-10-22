import 'package:flutter/material.dart';

import 'package:concours/firestore_config.dart';

class UpcomingMatchesPage extends StatefulWidget {
  @override
  _UpcomingMatchesPageState createState() => _UpcomingMatchesPageState();
}

class _UpcomingMatchesPageState extends State<UpcomingMatchesPage> {
  FirestoreConfig firestoreConfig;
  List data = [];
  
  /// Initializes scheduls collection
  @override
  initState(){
    super.initState();
    firestoreConfig = new FirestoreConfig("schedule");
    this.setup();
    this.data = [];
  }

  Future<void> setup() async {
    var querySnapshot = firestoreConfig.getSnapshot();

    querySnapshot.listen((snapshot){
      snapshot.documents.forEach((doc){
        print(doc.data);
        this.data.add(doc.data);
      });
    });

    print("DATA: ${data.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Upcoming Matches")
    );
  }
}