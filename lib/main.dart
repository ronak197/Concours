import 'package:flutter/material.dart';
import 'package:concours/home.dart';
import 'package:concours/loginPage.dart';
import 'package:concours/user_config.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserConfig userConfig;

  bool isSignedIn = false;

  @override
  void initState(){
    super.initState();
    this.userConfig = new UserConfig();
    this.setup();
    this.isSignedIn = false;
  }

  Future<void> setup() async {
    bool _isSignedIn = await userConfig.isLoggedIn();
    setState(() {
      this.isSignedIn = _isSignedIn;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return isSignedIn ? MaterialApp(
      title: "Concours",
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage()
    ) : MaterialApp(
      title: 'Concours',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}