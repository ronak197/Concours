import 'package:flutter/material.dart';
import 'package:concours/scoreboard.dart';

class Page extends StatelessWidget {
  String title;

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

  void initState(){
    super.initState();
    tabController = new TabController(
      length: 5,
      vsync: this
    );
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
              child: Text(
                'Sanket Chaudhari',
                style: TextStyle(
                  color: Colors.white
                )
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
              title: Text('Settings'),
              onTap: () {
                // Update the state of the app
                // ...
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
          Page("@sanket143"),
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