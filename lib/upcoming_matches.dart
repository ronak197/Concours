import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        setState((){
          this.data.add(doc.data);
        });

        
      });
    });

    print("DATA: ${data.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          var formatter = new DateFormat('H:m d MMM yy');

          this.data.forEach((data){
            String formatted = formatter.format(data["timestamp"]);

            print(formatted);
          });

          return Card(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    formatter.format(this.data[index]["timestamp"])
                  ),
                  Text(
                    this.data[index]["sport"],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        this.data[index]["players"][0]["name"]
                      ),
                      Text(
                        this.data[index]["players"][1]["name"]
                      )
                    ],
                  )
                ]
              )
            ) 
          );
        },
      )
    );
  }
}