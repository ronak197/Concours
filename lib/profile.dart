import 'package:flutter/material.dart';
import 'package:concours/user_config.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map userData;

  @override
  void initState(){
    super.initState();
    this.setup();
  }


  Future<void> setup() async {
    UserConfig userConfig = new UserConfig();

    Map data = await userConfig.getUser();

    setState((){
      this.userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          userData != null ? Container(
            width: 70.0,
            height: 70.0,
            margin: EdgeInsets.only(
              bottom: 15.0
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  userData["photoUrl"]
                )
              )
            )
          ) : CircleAvatar(
            child: Icon(Icons.person)
          ),
          Text(userData != null ? userData["displayName"] : ""),
          Text(userData != null ? userData["email"] : "")
        ]
      )
    );
  }
}