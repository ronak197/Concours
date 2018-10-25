import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:concours/firestore_config.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  FirestoreConfig firestoreConfig;
  List data = [];
  Map _reference;
  
  /// Initializes schedule collection
  @override
  initState(){
    super.initState();
    firestoreConfig = new FirestoreConfig("ended");
    this.data = [];
    this._reference = {
      "1S": "1st Singles",
      "2S": "2nd Singles",
      "3S": "3rd Singles",
      "1D": "1st Doubles",
      "2D": "2nd Doubles"
    };

    this.setup();
  }

  Future<void> setup() async {
    var querySnapshot = firestoreConfig.getSnapshot();
    
    querySnapshot.listen((snapshot){
      List docs = snapshot.documents;
      var dateFormatter = new DateFormat('dd MMM');

      docs.sort((match1, match2){
        var r = match1.data["timestamp"].compareTo(match2.data["timestamp"]);
        return r;
      });

      setState((){
        this.data = [];
      });

      docs.forEach((doc){
        var today = DateTime.now().day;
        var matchTime = DateTime.parse(doc.data["timestamp"].toString());
        var matchday = matchTime.day;

        if(today == matchday){
          doc.data["timesince"] = "Today";
        }
        else if(today == matchday - 1){
          doc.data["timesince"] = "Tomorrow";
        }
        else {
          doc.data["timesince"] = dateFormatter.format(doc.data["timestamp"]);
        }

        this.data.add(doc.data);

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: this.data.length != 0 ? ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){

          return Card(
            margin: EdgeInsets.only(left: 5.0,right: 5.0,bottom: 5.0,top: 5.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  CardHeader(
                    "${this.data[index]["sport"]} " + 
                    "${this._reference[this.data[index]["type"]]} " + 
                    "(${this.data[index]["label"]})",
                    this.data[index]["category"]
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            PlayerLabel(
                              this.data[index]["participants"][0]["team"]
                            ),
                          ]
                        )
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            PlayerLabel(
                              this.data[index]["participants"][1]["team"]
                            ),
                          ]
                        )
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          this.data[index]["timesince"],
                          style: TextStyle(color: Colors.black54),
                        ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${this.data[index]["result"]} won by " +
                          "${(this.data[index]["participants"][0]["score"] - this.data[index]["participants"][1]["score"]).abs()}  " +
                          "${this.data[index]["participants"][0]["score"]}/${this.data[index]["participants"][1]["score"]}"                          
                          ,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ]
                    ),
                  ),
                ]
              )
            ) 
          );
        },
      ) : Center(
        child: Text(
          "No Past Matches!",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey
          )
        )
      )
    );
  }
}

class CardHeader extends StatelessWidget {
  final String heading;
  final String category;

  CardHeader(
    this.heading,
    this.category
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: Colors.redAccent,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.heading,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0
            )
          ),
          Text(
            this.category,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
            )
          )
        ]
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
        color: Colors.black,
      ),
    );
  }
}