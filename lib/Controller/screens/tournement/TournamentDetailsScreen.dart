import 'package:flutter/material.dart';
import 'package:sportpal/Controller/screens/Stadiums/Widgets/StadiumCard.dart';
import 'package:sportpal/Model/Tournament.dart';
import 'package:sportpal/constants.dart';
import 'package:sportpal/variables.dart';
import 'draw/TournamentDrawScreen.dart';


class TournamentDetailsScreen extends StatefulWidget {

  const TournamentDetailsScreen({Key? key,required this.tournement}) : super(key: key);
  final Tournament tournement;
  @override
  _TournamentDetailsScreenState createState() => _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {

  bool pressedStar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  pressedStar = true;
                });
                //todo add tournament to bookmark
              },
              icon: !pressedStar ? Icon(Icons.star_outline):Icon(Icons.star)
          )
        ],
        title: Text(
          widget.tournement.title.toString() + " tournament ",
          style: TextStyle(
            fontSize: appBarTitleSize
          ),
        ),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0,top: 28),
              child: Row(
                children: [
                  Text(
                    "Organised by : ",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Text(
                      "Mr Haykel Lakhdhar",
                      style: TextStyle(
                        fontSize: 24
                      ),
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Verified",style: TextStyle(fontSize: 20,color: Colors.blue),
                  ),
                  SizedBox(width: 8,),
                  Icon(Icons.verified,color: Colors.blue,)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text(
                "will take place in : ",
              style: TextStyle(
                fontSize: 20,fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 10,),
            Text(
             widget.tournement.prize.toString(),
              style: TextStyle(
                  fontSize: 28,
                fontWeight: FontWeight.bold,
                color: themeColor
              ),
            ),

            StadiumCard(title: widget.tournement.title.toString(), description: "Megrine", rating: "4.3", imageUrl: "https://medias.lequipe.fr/img-photo-jpg/l-etihad-stadium-a-ete-mis-en-avant-dans-une-surprenante-etude-j-prevost-l-equipe/1500000001223124/0:0,1995:1330-1200-800-75/71f2d.jpg"),
            SizedBox(height: 10,),
            Text(
                "Available places : ",
              style: TextStyle(
                color: themeColor,
                fontSize: 24,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 4,),
            Text(
              "27/32",
              style: TextStyle(
                  color: themeColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Inscription fee : 60dt for team",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.w500
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 28),
              child: Row(
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'ProductSans'
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 48.0),
                    child: Opacity(
                      opacity: 1,
                      child: Transform.rotate(
                        angle: 0.5,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green,width: 4),
                          ),
                          child: Text(
                            "Open",textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 34,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TournamentDrawScreen(tournement: widget.tournement)));
                    },
                    child: Container(
                      height: 45,
                      width: 160,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: themeColor),
                      child: Center(
                        child: Text(
                          "Check draw",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      //TODO add paypal payment or stripe
                    },
                    child: Container(
                      height: 45,
                      width: 160,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: themeColor),
                      child: Center(
                        child: Text(
                          "Payment",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

}
