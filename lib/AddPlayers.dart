import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'registration.dart';

class TeamInfo{
  String teamName="";
  String collegeName="";
  String contactNo="";
  String selectedSport = 'Select a Sport';
  String category="";
}

final TeamInfo teamInfo = new TeamInfo();

class AddPlayersPage extends StatefulWidget {

  AddPlayersPage(String teamName, String collegeName,String contactNo, String selectedSport, String category){
    teamInfo.teamName=teamName;
    teamInfo.collegeName=collegeName;
    teamInfo.contactNo=contactNo;
    teamInfo.selectedSport=selectedSport;
    teamInfo.category=category;
  }

  @override
  _AddPlayersPageState createState() => _AddPlayersPageState();
}

class _AddPlayersPageState extends State<AddPlayersPage> with TickerProviderStateMixin {

  int currentStep = 0;

  List<Step> mySteps = [];

  List<Step> getListOfSteps(){
    mySteps = [];
      for(int i = 0; i < playerInfoSteps.length; i+=1){
        mySteps.add(playerInfoSteps[i].playerStep(i+1));
      }
      return mySteps;
  }

  static List<PlayerInfo> playerInfoSteps = [
    new PlayerInfo(),
  ];

  void changeCurrentStepContinue(){
    setState(() {
      if(currentStep == playerInfoSteps.length-1){
        playerInfoSteps.add(new PlayerInfo());
        mySteps.add(playerInfoSteps[currentStep+1].playerStep(currentStep+1));
      }
      ++currentStep;
    });
  }

  void changeCurrentStepCancel(){
    setState(() {
      if(currentStep>0) {
        --currentStep;
      }
    });
  }

  void changeCurrentStepTapped(index){
    setState(() {
      currentStep=index;
    });
  }
//
  void _register(){
    int count=0;
    for(int i=0; i<playerInfoSteps.length; i+=1) {
      final form = playerInfoSteps[i].formKey.currentState;
      if (form.validate()) {
         form.save();
         ++count;
      }
    }
    if(count==playerInfoSteps.length){

      Map<String,dynamic> data = new Map();

      data.putIfAbsent("TeamName", () => "${teamInfo.teamName}");
      data.putIfAbsent("CollegeName", () => "${teamInfo.collegeName}");

      Map<String,dynamic> data1 = new Map();

      for(int i=0; i<playerInfoSteps.length; i+=1) {
        Map<String,String> tempData=new Map();
        print("Name: ${playerInfoSteps[i].name}, Age: ${playerInfoSteps[i].age}, Email Id: ${playerInfoSteps[i].email}");
        tempData.putIfAbsent("playerName", () => "${playerInfoSteps[i].name}");
        tempData.putIfAbsent("playerAge", () => "${playerInfoSteps[i].age}");
        tempData.putIfAbsent("playerEmail", () => "${playerInfoSteps[i].email}");
        data1.putIfAbsent("Player_$i",()=>tempData);
      }

      data.putIfAbsent("Players", ()=>data1);
      sendToFireStore(data);
    }
  }

  void sendToFireStore(var data){
    DocumentReference documentReference = Firestore.instance.document("${teamInfo.selectedSport}/${teamInfo.category}/");
    documentReference.setData(data)
        .whenComplete((){
      print("Document Added");
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: new IconButton(
          onPressed: () => Navigator.pop(context,RegistrationPage),
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xffdc143c),
          ),
        ),
        title: new Container(
          child: Image.asset(
            "./assets/concours_icon.png",
            scale: 3.0,
          ),
        ),
        centerTitle: true,
      ),
      body:
      Column(
        children: <Widget>[
          Container(
            child: new Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
              child: new Container(
                child: Column(
                  children: <Widget>[
                    new Text(
                      "Add Players",
                      style: TextStyle(
                        color: Color(0xffdc143c),
                        fontSize: 20.0,
                      ),
                    ),
                   Container(
                     constraints: BoxConstraints.loose(new Size(double.maxFinite,450.0)),
                     child: new Stepper(
                       steps: getListOfSteps(),
                       currentStep: currentStep,
                       onStepContinue: changeCurrentStepContinue,
                       onStepCancel: changeCurrentStepCancel,
                       onStepTapped: changeCurrentStepTapped,
                     ),
                  ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child:Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    Container(
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.all(0.0),
                      color: Color(0xfff3b3c0),
                      child: new SizedBox(
                        width: double.maxFinite,
                        height: 60.0,
                        child: new FlatButton(
                          color: Color(0xfff3b3c0),
                          padding: EdgeInsets.all(0.0),
                          onPressed: _register,
                          child: new Text(
                            "Register",
                            style: TextStyle(
                                color: Color(0xffdc143c)
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
              )
          )
          ,
        ],
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }
}

class PlayerInfo{


  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String name;
  String age;
  String email;

  dynamic getFormKey(){
    return formKey;
  }

  Step playerStep(int stepValue){
    Step pStep;
    pStep = new Step(
      content: new Container(
        child: Column(
          children: <Widget>[
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffdc143c),
                            width: 1.0)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: Color(0xffdc143c)),
                      ),
                      validator: (val) =>
                      val.length <1  ? 'Too short' : null,
                      onSaved: (val) => name = val,
                    ),
                    padding: EdgeInsets.only(left: 4.0),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffdc143c),
                            width: 1.0)
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Age",
                        labelStyle: TextStyle(color: Color(0xffdc143c)),
                      ),
                      validator: (val) =>
                      val.length >2 || val.length==0 ? 'Invalid Age' : null,
                      onSaved: (val) => age = val,
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffdc143c),
                            width: 1.0)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email ID",
                        labelStyle: TextStyle(color: Color(0xffdc143c)),
                      ),
                      validator: (val) =>
                      !val.contains('@')  ? 'Invalid Email' : null,
                      onSaved: (val) => email = val,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isActive: true,
      title: Text("Player $stepValue"),
    );
    return pStep;
  }
}
