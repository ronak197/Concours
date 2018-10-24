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
      List docs = snapshot.documents;

      docs.sort((match1, match2){
        var r = match1.data["timestamp"].compareTo(match2.data["timestamp"]);
        return r;
      });

      setState((){
        this.data = [];
      });

      print(docs);
      snapshot.documents.forEach((doc){
        print('${doc.data["timestamp"]} ${DateTime.now()}');

        var matchTime = DateTime.parse(doc.data["timestamp"].toString());

        if(matchTime.isAfter(DateTime.now())){
          setState((){
            this.data.add(doc.data);
          });
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          var formatter = new DateFormat('HH:mm, d MMM');

          return Card(
            child: Container(
              child: Column(
                children: <Widget>[
                  CardHeader(
                    "${this.data[index]["sport"]} (${this.data[index]["label"]})"
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: PlayerLabel(
                          this.data[index]["participants"][0]["team"]
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
                          this.data[index]["participants"][1]["team"]
                        ),
                      )
                    ]
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      left: 10.0,
                      right: 10.0
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Start Time: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          formatter.format(this.data[index]["timestamp"])
                        ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ground: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          this.data[index]["venue"],
                        ),
                      ]
                    ),
                  ),
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

  CardHeader(this.heading);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: Colors.redAccent,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Text(
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