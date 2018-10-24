import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:concours/firestore_config.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final formKey = GlobalKey<FormState>();
  
  String college1, college2;
  String team1, team2;
  String team_id1, team_id2;
  String sport, venue, label;
  String category;

  DateTime timestamp;

  bool _submit() {
    final form = formKey.currentState;
    FirestoreConfig firestoreConfig = new FirestoreConfig("schedule");

    if(form.validate()){
      form.save();
      Map<String, dynamic> data = {
        "participants": [
          {
            "college": college1,
            "team": team1,
            "team_id": team_id1
          },
          {
            "college": college2,
            "team": team2,
            "team_id": team_id2,
          }
        ],
        "category": category,
        "timestamp": timestamp,
        "venue": venue,
        "sport": sport,
        "label": label
      };

      firestoreConfig.addData(team_id1 + "vs" + team_id2 + timestamp.toString(), data);
      return true;
    }

    return false;
  }

  _validate(value){
    if(value.isEmpty){
      return "Please Enter some text";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Text("Team 1"),
            TextFormField(
              decoration: InputDecoration(
                hintText: "College Name"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => college1 = val,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Team Name"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => team1 = val,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Team ID"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => team_id1 = val,
            ),
            SizedBox(
              height: 30.0
            ),
            Text("Team 2"),
            TextFormField(
              decoration: InputDecoration(
                hintText: "College Name"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => college2 = val,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Team Name"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => team2 = val,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Team ID"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => team_id2 = val,
            ),
            SizedBox(
              height: 30.0
            ),
            Text(
              "Extras"
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Sport"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => sport = val,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Category"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => category = val
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Label"
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => label = val
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Venue",
              ),
              validator: (value) => _validate(value),
              onSaved: (val) => venue = val,
            ),
            DateTimePickerFormField(
              format: dateFormat,
              decoration: InputDecoration(labelText: 'Date'),
              onChanged: (dt) => setState(() => timestamp = dt),
            ),
            RaisedButton(
              child: Text(
                "Submit", 
              ),
              onPressed: (){
                if(_submit()){
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Added Successfully"),
                      );
                    },
                  );
                } else {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Field Empty"),
                      );
                    },
                  );
                }
              }
            )
          ]
        )
      )
    );
  }
}