import 'package:flutter/material.dart';

// Concours Files
import 'package:concours/scoreboard.dart';
import 'package:concours/profile.dart';
import 'package:concours/user_config.dart';
import 'package:concours/loginPage.dart';
import 'package:concours/upcoming_matches.dart';
import 'package:concours/registration.dart';
import 'package:concours/leaderboard.dart';
import 'package:concours/add_matches.dart';
import 'package:concours/info.dart';
import 'package:concours/scoreboard_admin.dart';
import 'package:concours/live_page.dart';
import 'package:concours/ended_matches.dart';
import 'package:concours/about.dart';

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
  String currentTitle;

  bool admin;
  bool isSignedIn = false;
  final List<String> titleName = ["Scoreboard","Past Matches","Upcoming Matches","Profile","Information"];

  void initState(){
    super.initState();
    this.admin = false;
    this.isSignedIn = false;
    this.setup();
    currentTitle = titleName[0];
    tabController = new TabController(
      length: 5,
      vsync: this
    );
    tabController.addListener(_handleSelected);
  }

  void _handleSelected(){
    setState(() {
      currentTitle = titleName[tabController.index];
    });
  }

  Future<void> setup() async {
    UserConfig userConfig = new UserConfig();
    Map data = await userConfig.getUser();

    setState((){
      this.userData = data;
      if(data["email"] == "chaudharisanket2000@gmail.com"){
        this.admin = true;
      }
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
        centerTitle: true,
        title: Text(
          currentTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
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
        child: ListView(
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
              title: Row(
                children: <Widget> [
                  Icon(Icons.info),
                  Text(' About Us'),
                ]
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutPage()
                  )
                );
              },
            ),
            ListTile(
              title: Row(
                children: <Widget> [
                  Icon(Icons.power_settings_new),
                  Text(' Log Out')
                ]
              ),
              onTap: () {
                _signOut();
              },
            ),
            this.admin ? ListTile(
              title: Text("Ended"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EndedMatchesScaffold()
                  )
                );
              }
            ) : Padding(
              padding: EdgeInsets.all(0.0)
            ),
            this.admin ? ListTile(
              title: Text("Live"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveScaffold()
                  )
                );
              }
            ) : Padding(
              padding: EdgeInsets.all(0.0)
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          this.admin ? AdminScoreboardPage() : ScoreBoard(),
          LeaderboardPage(),
          UpcomingMatchesPage(),
          this.admin ? MatchPage() : InfoPage()
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
              child: Icon(Icons.info)
            ),
          ]
        )
      ),
    );
  }
}