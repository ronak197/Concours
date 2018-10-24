import 'package:flutter/material.dart';
import 'firestore_config.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  FirestoreConfig firestoreConfig;

  @override
  initState(){
    super.initState();
    firestoreConfig = new FirestoreConfig("users");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Information Page")
    );
  }
}