import 'package:flutter/material.dart';


class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {

  String teamName1 = "TeamName1";
  String teamName2 = "TeamName2";
  String playersTeam1 = "PlayersTeam1";
  String playersTeam2 = "PlayersTeam2";
  String sportName = "SportName";
  String matchType = "MatchType";
  int scoreTeam1 = 10;
  int scoreTeam2 = 8;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
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
                        sportName,
                        style: TextStyle(
                          color: Color(0xFFff5252),
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        matchType,
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
                                  TextLabel(teamName1, true),
                                  TextLabel(playersTeam1, false)
                                ]
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextLabel(teamName2, true),
                                  TextLabel(playersTeam2, false)
                                ]
                              ),
                            )
                          ]
                        ),
                      ),
                      Score(scoreTeam1,scoreTeam2),
                    ]
                  )
                ),
                Info()
              ]
            )
          ),
        ),
      ]
    );
  }
}

class Info extends StatelessWidget {
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
                    "Badminton Singles",
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
                    "Sanket Chaudhari from team Cocktail vs Sumeet Varma from team FruitSalad",
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