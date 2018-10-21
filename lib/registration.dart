import 'package:flutter/material.dart';
import 'AddPlayers.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primaryColor: Colors.red,
          buttonColor: Colors.red
      ),
      home: new FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => new _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _teamName;
  String _collegeName;
  String _contactNo;
  String selectedSport = 'Select a Sport';
  String category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _next() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlayers(registrationFormKey: formKey,)));
    }
  }

  List<String> sportList = [
    "Badminton",
    "BasketBall",
    "Cricket",
    "Football",
    "Table-Tennis",
    "VolleyBall"
  ];



  var _radioValue;

  void handleRadioValueChange(int value){
    setState(() {
      _radioValue = value;
      switch(_radioValue){
        case 0: category = "Men";
        break;
        case 1: category = "Women";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
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
                child: new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new Center(
                        child: new Container(
                          child: Image.asset(
                            "./assets/registrationPageAssets/team_icon.png",
                            scale: 4.0,
                          ),
                        ),
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Team Name",
                          labelStyle: TextStyle(
                              color: Color(0xffdc143c)
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset(
                              "./assets/registrationPageAssets/teamName_icon.png",
                              scale: 3.0,
                            ),
                          ),
                        ),
                        validator: (val) => val.isEmpty || val.length <= 1 ? 'Invalid Team Name' : null,
                        onSaved: (val) => _teamName = val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "College Name",
                          labelStyle: TextStyle(
                            color: Color(0xffdc143c),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset(
                              "./assets/registrationPageAssets/college_icon.png",
                              scale: 3.0,
                            ),
                          ),
                        ),
                        validator: (val) =>
                        val.length <= 1 ? 'Too short' : null,
                        onSaved: (val) => _collegeName = val,
                      ),
                      new TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: "Contact No.",
                          labelStyle: TextStyle(
                            color: Color(0xffdc143c),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset(
                              "./assets/registrationPageAssets/contact_icon.png",
                              scale: 3.0,
                            ),
                          ),
                        ),
                        validator: (val) =>
                        val.length!=10  ? 'Enter 10 digit mobile No.' : null,
                        onSaved: (val) => _contactNo = val,
                      ),
                      new Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffdc143c),
                                width: 1.0)
                        ),
                        padding: EdgeInsets.all(5.00),
                        margin: EdgeInsets.only(top: 20.0),
                        child: DropdownButton<String>(
                            isExpanded: true,
                            items: sportList.map((String val) {
                              return new DropdownMenuItem<String>(
                                value: val,
                                child: new Text(val),
                              );
                            }).toList(),
                            hint: Text(
                              selectedSport,
                              style: new TextStyle(
                                color: Color(0xffdc143c),
                              ),
                            ),
                            onChanged: (newVal) {
                              selectedSport = newVal;
                              this.setState(() {});
                            }),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.00),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xffdc143c),
                              width: 1.0),
                        ),
                        child : new Row(
                          children: <Widget>[
                            new Text(
                              "Category : ",
                              style: TextStyle(
                                color: Color(0xffdc143c),
                              ),
                            ),
                            new Radio(
                              value: 0,
                              activeColor: Colors.red,
                              groupValue: _radioValue,
                              onChanged: (dynamic e) => handleRadioValueChange(e),
                            ),
                            new Text(
                              "Men   ",
                              style: TextStyle(
                                color: Color(0xffdc143c),
                              ),
                            ),
                            new Radio(
                              value: 1,
                              activeColor: Colors.red,
                              groupValue: _radioValue,
                              onChanged: (dynamic e) => handleRadioValueChange(e),
                            ),
                            new Text(
                              "Women",
                              style: TextStyle(
                                  color: Color(0xffdc143c)
                              ),
                            ),
                          ],
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
                          onPressed: _next,
                          child: new Text(
                              "Next",
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
