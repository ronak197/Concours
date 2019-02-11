import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FootballDetails extends StatefulWidget {
  @override
  _FootballDetailsState createState() => _FootballDetailsState();
}

class _FootballDetailsState extends State<FootballDetails> {
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
            SubstitutionCard(),
            GoalCard(),
            YellowCard()
          ],
        )
      ),
    );
  }
}



class SubstitutionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SubstituteIcon(),
                        Text(
                          "SUBSTITUTION",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "IN",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13.0
                          )
                        ),
                        Text(
                          "Sanket Chaudhari",
                          style: TextStyle(
                            fontSize: 20.0
                          ),
                        ),
                        Text(
                          "DA-IICT #143",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0
                          )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "OUT",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13.0
                          )
                        ),
                        Text(
                          "Ronak Jain",
                          style: TextStyle(
                            fontSize: 20.0
                          ),
                        ),
                        Text(
                          "DA-IICT #143",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0
                    ),
                    child: Divider()
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Sanket enters the action to replace Ronak on the flank, who has been underwhelming today.",
                      style: TextStyle(
                        color: Color(0xFF3C4043)
                      )
                    ),
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }
}

class GoalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Card(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                color: Colors.blueAccent,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          IconData(0xe903, fontFamily: "Football"),
                          color: Colors.white
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "GOOOAAALLL!!!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                color: Color(0xFF3045DA),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: WhiteText(
                        "Russia (5)"
                      ),
                    ),
                    Expanded(
                      child: WhiteText(" - ")
                    ),
                    Expanded(
                      child: WhiteText("(0) Saudi Arab")
                    )
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Sanket Chaudhari",
                          style: TextStyle(
                            fontSize: 20.0
                          )
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "DA-IICT",
                          style: TextStyle(
                            color: Colors.black45
                          )
                        )
                      ],
                    ),
                    Divider(),
                    Text(
                      "GOALLLLLLLLLLL!!!!!! 5-0!!!!!! GOLOVIN GETS A DESERVED GOAL!!! Russia compound Saudi Arabia's agony as the winger curls a fine strike from the free-kick. Golovin lifted his effort over the wall and it had the perfect amount of bend on it to drift inside the post before nestling into the back of the net.",
                      style: TextStyle(
                        color: Colors.black87
                      ),
                    )
                  ],
                )
              )
            ]
          )
        )
      )
    );
  }
}

class WhiteText extends StatelessWidget {
  final String content;
  
  WhiteText(this.content);
  @override
  Widget build(BuildContext context) {
    return Text(
      this.content,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        wordSpacing: 5.0,
      )
    );
  }
}

class YellowCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Card(
                    child: SizedBox(
                      width: 13.0,
                      height: 20.0
                    ),
                    color: Colors.amberAccent
                  ),
                  SizedBox(
                    width: 5.0
                  ),
                  Text(
                    "YELLOW CARD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Sanket Chaudhari",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    )
                  ),
                  Text(
                    "DA-IICT",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300
                    )
                  ),
                  SizedBox(
                    height: 10.0
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0
                    ),
                    child: Text(
                      "Sanket Chaudhari is booked for his challenge on Ronak"
                    ),
                  )
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}

class FootballScoreLine extends StatelessWidget {
  final String lcontent;
  final String rcontent;
  final String labelcontent;

  FootballScoreLine(
    this.lcontent,
    this.labelcontent,
    this.rcontent,
  );
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(this.lcontent, style: TextStyle(color: Colors.red, fontSize: 28.0),),
              ],
            ),
          ),
        ),
        Expanded(
          child: Text(
            this.labelcontent,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0),
            )
        ),
        Flexible(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(this.rcontent, style: TextStyle(color: Colors.red, fontSize: 28.0),),
              ],
            ),
          )
        ),
      ],
    );
  }
}

class SubstituteIcon extends StatelessWidget {
  final Widget substituteIcon = SvgPicture.asset(
    "assets/sports/substitution_icon.svg",
    width: 24,
  );

  @override
  Widget build(BuildContext context) {
    return substituteIcon;
  }
}