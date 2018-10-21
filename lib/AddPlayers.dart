import 'package:flutter/material.dart';

class AddPlayers extends StatelessWidget {

  final registrationFormKey;
  AddPlayers({this.registrationFormKey});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new AddPlayersPage(),
      theme: new ThemeData(
        primaryColor: Color(0xffdc143c)
      ),
    );
  }
}

class AddPlayersPage extends StatefulWidget {
  @override
  _AddPlayersPageState createState() => _AddPlayersPageState();
}

class _AddPlayersPageState extends State<AddPlayersPage> with TickerProviderStateMixin {

  int currentStep = 0;

  List<Step> mySteps = [];
  void getListOfSteps(){


    setState(() {
      for(int i = 0; i < playerInfoSteps.length; i+=1){
        PlayerInfo playerInfo = new PlayerInfo();
        mySteps.add(playerInfo.playerStep(i+1));
      }
    });
  }

  @override
  void initState(){
    super.initState();
    this.mySteps = [];
    this.getListOfSteps();
  }

  static List<PlayerInfo> playerInfoSteps = [
    new PlayerInfo(),
    new PlayerInfo(),
    new PlayerInfo()
  ];

  void changeCurrentStepContinue(){
    var _currentStep = currentStep;


    print("$_currentStep ${mySteps.length}");
    setState(() {
      PlayerInfo playerInfo = new PlayerInfo();
      // mySteps.add(playerInfo.playerStep(_currentStep));
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
        print("READY TO PASS INTO FIREBASE");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xffdc143c),
          ),
          onPressed: null,
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
                       steps: this.mySteps,
                       currentStep: this.currentStep,
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
