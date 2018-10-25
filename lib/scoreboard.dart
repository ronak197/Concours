import 'package:flutter/material.dart';
import 'package:concours/firestore_config.dart';


class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  FirestoreConfig firestoreConfig;
  List data;
  Map _reference;

  String teamName1 = "TeamName1";
  String teamName2 = "TeamName2";
  String playersTeam1 = "PlayersTeam1";
  String playersTeam2 = "PlayersTeam2";
  String sportName = "SportName";
  String matchType = "MatchType";
  int scoreTeam1 = 10;
  int scoreTeam2 = 8;

  @override
  void initState(){
    super.initState();

    this.firestoreConfig = new FirestoreConfig("live");
    this._reference = {
      "1S": "1st Singles",
      "2S": "2nd Singles",
      "3S": "3rd Singles",
      "1D": "1st Doubles",
      "2D": "2nd Doubles"
    };
    this.data = [];
    this.setup();
  }

  Future<void> setup() async {
    Stream querySnapshot = firestoreConfig.getSnapshot();

    querySnapshot.listen((snapshot){
      List docs = snapshot.documents;

      setState((){
        this.data = [];
        docs.forEach((doc){
          if(doc.data["live"]){
            this.data.add(doc.data);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.data.length != 0 ? ListView.builder(
      itemCount: this.data.length,
      itemBuilder: (BuildContext context, int index){
        return Card(
          margin: EdgeInsets.only(left: 5.0,right: 5.0,bottom: 10.0),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(15.0),
                  color: Color(0xFFFEECEC),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.data[index]["sport"],
                        style: TextStyle(
                          color: Color(0xFFff5252),
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        this._reference[data[index]["type"]],
                        style: TextStyle(
                          color: Color(0xffff5252),
                          fontSize: 15.0
                        )
                      )
                    ]
                  )
                ),
                Container(
                  color: Color(0xffff5252),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 15.0
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextLabel(this.data[index]["participants"][0]["team"], true),
                                  TextLabel(this.data[index]["participants"][0]["name"], false)
                                ]
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextLabel(this.data[index]["participants"][1]["team"], true),
                                  TextLabel(this.data[index]["participants"][1]["name"], false)
                                ]
                              ),
                            )
                          ]
                        ),
                      ),
                      Score(
                        this.data[index]["participants"][0]["score"],
                        this.data[index]["participants"][1]["score"]
                      ),
                    ]
                  )
                ),
                Info(
                  "${this.data[index]["sport"]}, ${this._reference[this.data[index]["type"]]}",
                  "${this.data[index]["participants"][0]["name"]} from " +
                  "team ${this.data[index]["participants"][0]["team"]} " +
                  "vs " +
                  "${this.data[index]["participants"][1]["name"]} from " +
                  "team ${this.data[index]["participants"][1]["team"]} "
                )
              ]
            )
          ),
        );
      }
    ) : Container(
      color: Colors.white,
      child: Center(
        child: Text(
          "No Ongoing matches",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey
          )
        )
      )
    );
  }
}

class Info extends StatelessWidget {
  final String title;
  final String content;

  Info(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                    bottom: 5.0
                  ),
                  child: Text(
                    this.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                    bottom: 5.0
                  ),
                  child: Text(
                    this.content,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red
                    )
                  )
                ),
              ],
            )
          )
        ]
      )
    );
  }
}

class Score extends StatelessWidget {
  final int one, two;
  
  Score(this.one, this.two);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ScoreText(one.toString()),
              ),
              Expanded(
                child: ScoreText(two.toString())
              )
            ]
          )
        ]
      )
    );
  }
}

class ScoreText extends StatelessWidget {
  final String text;

  ScoreText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        fontWeight: FontWeight.bold
      )
    );
  }
}

class TextLabel extends StatelessWidget {
  final String text;
  final bool bold;
  TextLabel(this.text, this.bold);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal
        ),
      ),
    );
  }
}