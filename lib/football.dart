import 'package:flutter/material.dart';
import 'package:concours/football/timeline.dart';

class FootballDetails extends StatefulWidget {
  @override
  _FootballDetailsState createState() => _FootballDetailsState();
}

class _FootballDetailsState extends State<FootballDetails> with TickerProviderStateMixin {

  TabController footballTabController;
  String currentFootballTab;

  final List<String> footballTabList = [
    "timeline",
    "stats",
    "lineups"
  ];

  void initState() {
    super.initState();
    currentFootballTab = footballTabList[0];
    footballTabController = TabController(
      length: 3,
      vsync: this
    );

    footballTabController.addListener(_handleSelectedFootballSport);
  }

  void _handleSelectedFootballSport(){
    setState(() {
      currentFootballTab = footballTabList[footballTabController.index];
    });

    print(currentFootballTab);
  }

  void dispose(){
    super.dispose();
    footballTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: Text("Real Madrid", style: TextStyle(color: Colors.red, fontSize: 20.0),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 10.0,
                  child: Center(child: Text("vs", style: TextStyle(fontSize: 12.0),)),
                ),
                Flexible(
                  child: Center(
                    child: Text("FC Barcelona", style: TextStyle(color: Colors.red, fontSize: 20.0),),
                  )
                )
              ],
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 7.0),
            ),
            Text("Semi-Finals", style: TextStyle(fontSize: 13.0, color: Colors.grey),),
            Padding(
              padding: EdgeInsets.only(top: 7.0),
            ),
            FootballScoreLine("1", "-", "5"),
            Divider(),
            TabBar(
              controller: footballTabController,
              tabs: <Tab>[
                Tab(
                  child: Text(
                    "Timeline",
                    style: TextStyle(
                      color: Colors.black
                    )
                  )
                ),
                Tab(
                  child: Text(
                    "Stats",
                    style: TextStyle(
                      color: Colors.black
                    )
                  )
                ),
                Tab(
                  child: Text(
                    "Line Ups",
                    style: TextStyle(
                      color: Colors.black
                    ),
                  )
                )
              ]
            ),
            TabBarView(
              children: <Widget>[
                TimelinePage(),
                TimelinePage(),
                TimelinePage(),
              ],
              controller: footballTabController
            ),
          ],
        )
      ),
    );
  }
}