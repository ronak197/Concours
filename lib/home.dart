import 'package:flutter/material.dart';
import 'package:concours/scoreboard.dart';
import 'package:concours/profile.dart';
import 'package:concours/user_config.dart';
import 'package:concours/loginPage.dart';

@immutable
class Page extends StatelessWidget {
  final String title;

  Page(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: const Color(0xFFDC143C),
            fontSize: 20.0
          ),
        )
      )
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tabController;
  Map userData;

  bool isSignedIn = false;

  void initState(){
    super.initState();
    this.isSignedIn = false;
    this.setup();
    tabController = new TabController(
      length: 5,
      vsync: this
    );
  }

  Future<void> setup() async {
    UserConfig userConfig = new UserConfig();
    Map data = await userConfig.getUser();

    setState((){
      this.userData = data;
    });

    print(this.userData);
  }

  void _signOut() async {
    UserConfig userConfig = new UserConfig();
    await userConfig.signOut();

    if(!userConfig.isSignedIn){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage()
        ),
        (Route<dynamic> route) => false
      );
    }
    
    print("User Sign Out");
  }

  void dispose(){
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Concours",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red
          )
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red
        ),
        elevation: 0.0,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userData != null ? userData["displayName"] : "",
                        style: TextStyle(
                          color: Colors.white
                        )
                      ),
                      Text(
                        userData != null ? userData["email"] : "",
                        style: TextStyle(
                          color: Colors.white
                        )
                      )
                    ],
                  )        
                ]
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            ),
            ListTile(
              title: Text('Add Team'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                _signOut();
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          ScoreBoard(),
          Page("Leaderboard"),
          Page("Upcoming Matches"),
          ProfilePage(),
          Page("Information")
        ],
        controller: tabController
      ),
      bottomNavigationBar: Material(
        color: Colors.redAccent,
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(
              child: Icon(Icons.insert_chart),
            ),
            Tab(
              child: Icon(Icons.trending_up)
            ),
            Tab(
              child: Icon(Icons.schedule)
            ),
            Tab(
              child: Icon(Icons.person)
            ),
            Tab(
              child: Icon(Icons.info)
            ),
          ]
        )
      ),
    );
  }
}