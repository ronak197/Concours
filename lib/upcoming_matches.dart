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
  
  /// Initializes schedule collection
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

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          var formatter = new DateFormat('H:m d MMM yy');

          return Card(
            child: Container(
              child: Column(
                children: <Widget>[
                  CardHeader(
                    heading: this.data[index]["sport"],
                    subHeading: this.data[index]["sub"],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: PlayerLabel(
                          this.data[index]["players"][0]["name"]
                        )
                      ),
                      Expanded(
                        child: Text(
                          "VS",
                          textAlign: TextAlign.center,
                        )
                      ),
                      Expanded(
                        child: PlayerLabel(
                          this.data[index]["players"][1]["name"]
                        ),
                      )
                    ]
                  ),
                  Text(
                    formatter.format(this.data[index]["timestamp"])
                  ),
                  Text(
                    this.data[index]["sport"],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
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

class CardHeader extends StatelessWidget {
  final String heading;
  final String subHeading;
  CardHeader({this.heading, this.subHeading});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: Colors.redAccent,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: this.subHeading != null ? 
        Text(
          "${this.heading} ( ${this.subHeading})",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0
          )
        ) :
        Text(
          "${this.heading}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0
          )
        )
    );
  }
}

class PlayerLabel extends StatelessWidget {
  final String playerName;

  PlayerLabel(this.playerName);
  @override
  Widget build(BuildContext context) {
    return Text(
      this.playerName,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold
      ),
    );
  }
}