import 'package:flutter/material.dart';
import 'package:concours/loginpage.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concours',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}