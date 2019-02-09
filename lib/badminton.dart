import 'package:flutter/material.dart';

class BadmintonScoreboard extends StatefulWidget {
  @override
  _BadmintonScoreboardState createState() => _BadmintonScoreboardState();
}

class _BadmintonScoreboardState extends State<BadmintonScoreboard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: Text("India", style: TextStyle(color: Colors.red, fontSize: 20.0),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 10.0,
                  child: Center(child: Text("vs", style: TextStyle(fontSize: 12.0),)),
                ),
                Flexible(
                    child: Center(
                      child: Text("Australia", style: TextStyle(color: Colors.red, fontSize: 20.0),),
                    )
                )
              ],
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 7.0),
            ),
            Text("Semi-Finals", style: TextStyle(fontSize: 14.0, color: Colors.black54),),
            Padding(
              padding: EdgeInsets.only(top: 7.0),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("3", style: TextStyle(color: Colors.red, fontSize: 28.0),),
                        Text("Sania Nehwal", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
                      ],
                    ),
                  ),
                ),
                Text("-", style: TextStyle(fontSize: 16.0),),
                Flexible(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text("4", style: TextStyle(color: Colors.red, fontSize: 28.0),),
                          Text("Moris", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
                        ],
                      ),
                    )
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class BadmintonPastMatches extends StatefulWidget {
  @override
  _BadmintonPastMatchesState createState() => _BadmintonPastMatchesState();
}

class _BadmintonPastMatchesState extends State<BadmintonPastMatches> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: Text("India", style: TextStyle(color: Colors.red, fontSize: 20.0),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 10.0,
                child: Center(child: Text("vs", style: TextStyle(fontSize: 12.0),)),
              ),
              Flexible(
                  child: Center(
                    child: Text("Australia", style: TextStyle(color: Colors.red, fontSize: 20.0),),
                  )
              )
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: 7.0),
          ),
          Text("Final Score (Semi-Finals)", style: TextStyle(fontSize: 14.0, color: Colors.black54),),
          Padding(
            padding: EdgeInsets.only(top: 7.0),
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("3", style: TextStyle(color: Colors.red, fontSize: 28.0),),
                    ],
                  ),
                ),
              ),
              Text("-", style: TextStyle(fontSize: 16.0),),
              Flexible(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("4", style: TextStyle(color: Colors.red, fontSize: 28.0),),
                      ],
                    ),
                  )
              ),
            ],
          ),
          Divider(),
          Text("Second Singles",style: TextStyle(color: Colors.black45, fontSize: 13.0),),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: <Widget>[
              Flexible(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("Sania Nehwal", style: TextStyle(color: Colors.green, fontSize: 12.0),)
                    ],
                  ),
                ),
              ),
              Flexible(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("Moris", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
                      ],
                    ),
                  )
              ),
            ],
          ),
          Divider(),
          Text("First Singles",style: TextStyle(color: Colors.black45, fontSize: 13.0),),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: <Widget>[
              Flexible(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("sanket chaudari", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
                    ],
                  ),
                ),
              ),
              Flexible(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("ronak jain", style: TextStyle(color: Colors.green, fontSize: 12.0),)
                      ],
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BadmintonUpcomingMatches extends StatefulWidget {
  @override
  _BadmintonUpcomingMatchesState createState() => _BadmintonUpcomingMatchesState();
}

class _BadmintonUpcomingMatchesState extends State<BadmintonUpcomingMatches> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: Text("India", style: TextStyle(color: Colors.red, fontSize: 20.0),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 10.0,
                  child: Center(child: Text("vs", style: TextStyle(fontSize: 12.0),)),
                ),
                Flexible(
                    child: Center(
                      child: Text("Australia", style: TextStyle(color: Colors.red, fontSize: 20.0),),
                    )
                )
              ],
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 7.0),
            ),
            Text("Semi-Finals", style: TextStyle(fontSize: 14.0, color: Colors.black54),),
            Padding(
              padding: EdgeInsets.only(top: 7.0),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("Date & Time", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                        Text("23rd, 18:50", style: TextStyle(color: Colors.red, fontSize: 16.0),),
                      ],
                    ),
                  ),
                ),
                Flexible(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text("Venue", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                          Text("SAC Court - 1", style: TextStyle(color: Colors.red, fontSize: 16.0),),
                        ],
                      ),
                    )
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
