import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Model/Matche.dart';
import '../../../../Model/Team.dart';
import '../../../../constants.dart';
import '../../../../variables.dart';



class MatchHistoryDetailTennis extends StatefulWidget {
  const MatchHistoryDetailTennis({Key? key, required this.match}) : super(key: key);
  final Matche match ;

  @override
  _MatchHistoryDetailTennisState createState() => _MatchHistoryDetailTennisState();
}

class _MatchHistoryDetailTennisState extends State<MatchHistoryDetailTennis> {


  String data = "Victory";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        centerTitle: true,
        title: Text(
          "Match History",
          style: TextStyle(fontSize: appBarTitleSize),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              "Against "+ widget.match.teamB!.players[0]!.fullName!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontFamily: 'Cardo'
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              left: 30,
              right: 30,
              bottom: 25,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black12,
                      offset: Offset(0, 6),
                    ),
                  ]),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Victory",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: changeColor(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("VS",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: changeColor(), width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              image: DecorationImage(
                                  image:
                                  NetworkImage(widget.match.teamB!.players[0]!.profilePic!)),
                          ),
                        ),
                        Text(
                          "3",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "2",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: changeColor(), width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              image: DecorationImage(
                                  image:
                                  NetworkImage(widget.match.teamA!.players[0]!.profilePic!)
                              ),
                        ),
                        )],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.sports_tennis,),
                        Padding(
                          padding: const EdgeInsets.only(left:75.0),
                          child: Text("7",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: Text("5",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: Icon(Icons.sports_tennis,),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.sports_tennis,),
                        Padding(
                          padding: const EdgeInsets.only(left:75.0),
                          child: Text("4",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: Text("6",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: Icon(Icons.sports_tennis,),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.sports_tennis,),
                        Padding(
                          padding: const EdgeInsets.only(left:75.0),
                          child: Text("6",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: Text("3",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: Icon(Icons.sports_tennis,),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.sports_tennis,),
                        Padding(
                          padding: const EdgeInsets.only(left:75.0),
                          child: Text("2",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: Text("6",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: Icon(Icons.sports_tennis,),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.sports_tennis,),
                        Padding(
                          padding: const EdgeInsets.only(left:75.0),
                          child: Text("6",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: Text("4",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: Icon(Icons.sports_tennis,),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: RaisedButton(
                              color: Color(0xffefb814),
                              child: new Text(
                                'Add to favorites',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                // TODO add team to booksmrk
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          child: RaisedButton(
                              color: themeColor,
                              child: new Text(
                                'Done',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  changeColor() {
    if(data == "Victory"){
      return Colors.green[700];
    }else if (data == "Tie"){
      return Colors.grey;
    }else {
      return Colors.red;
    }
  }
}
