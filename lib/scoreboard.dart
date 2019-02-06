import 'package:flutter/material.dart';
import 'package:concours/badminton.dart';
import 'package:concours/basketball.dart';
import 'package:concours/cricket.dart';
import 'package:concours/tabletennis.dart';
import 'package:concours/volleyball.dart';
import 'package:concours/football.dart';

class ScoreBoard extends StatefulWidget {

  String selectedSport;

  ScoreBoard({this.selectedSport});

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedSport){
      case 'Badminton':
        print(widget.selectedSport);
        return BadmintonDetails();
        break;
      case 'Basketball':
        print(widget.selectedSport);
        return BasketballDetails();
        break;
      case 'Cricket':
        print(widget.selectedSport);
        return CricketDetails();
        break;
      case 'Football':
        print(widget.selectedSport);
        return FootballDetails();
        break;
      case 'Tabletennis':
        print(widget.selectedSport);
        return TabletennisDetails();
        break;
      case 'Volleyball':
        print(widget.selectedSport);
        return VolleyballDetails();
        break;
    }
    return null;
  }
}
