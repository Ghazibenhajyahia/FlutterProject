import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportpal/Controller/screens/Tennis/Match_history/MatchHistoryList.dart';
import 'package:sportpal/Controller/screens/news/pages/PopularNewsScreen.dart';
import 'package:sportpal/Controller/screens/news/pages/RecentNewsScreen.dart';
import 'package:sportpal/Controller/screens/news/pages/TrendingNewsScreen.dart';
import 'package:sportpal/constants.dart';
import 'package:sportpal/variables.dart';
import '../Foot/JoinFootballTeamsScreen.dart';
import '../Tennis/TennisPlayersTinder.dart';
import '../home/MenuWidget.dart';
import '../profil/profilScreen.dart';
import '../team/TeamScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../team/createTeamScreen.dart';
import '../tournement/TournementsListScreen.dart';
import '../tournement/createTournement.dart';

class NewsPageScreen extends StatefulWidget {
  const NewsPageScreen({Key? key}) : super(key: key);

  @override
  _NewsPageScreenState createState() => _NewsPageScreenState();
}

class _NewsPageScreenState extends State<NewsPageScreen> {
  late Future<bool> fetchedUser;
  late String fullname;
  late String profilPic;
  late Set<String> a;
  late SharedPreferences prefs;

  Future<bool> fetchUser() async {

    prefs = await SharedPreferences.getInstance();
a=prefs.getKeys();
    fullname = prefs.getString("fullName")!;
    profilPic = prefs.getString("profilePic")!;

    print(a);
    return true;
  }
  @override
  void initState() {
    fetchedUser = fetchUser();

    super.initState();
  }
  final screens =[
    TabBarView(
      children: [
        PopularTabView(),
        TrendingNewsScreen(),
        RecentNewsScreen()
      ],
    ),
    ProfilScreen(),
    selectedSport =="tennis" ? TennisPlayerTinderScreen() : FootBallTeam(),
    selectedSport == "tennis" ? TennisMatchHistoryList() : JoinFootballTeamsScreen(),
    selectedSport == "tennis" ?TournementScreenList(): CreateTeamScreen(),
  ];


  int index = 0;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home,size: 30,),
      Icon(FontAwesomeIcons.user,size: 30,),
      selectedSport == "tennis" ? Icon(Icons.sports_tennis,size: 30,):Icon(Icons.sports_soccer,size: 30,) ,
      Icon(Icons.bookmark_sharp,size: 30,),
      Icon(Icons.message,size: 30,),

    ];
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent ,
            animationDuration: Duration(milliseconds: 400),
            color: themeColor,
            items: items,
            height: 60,
            index: index,
            onTap: (index){
              setState(() {
                this.index=index;
              });
            },
          ),
          appBar: index == 0 ? PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: Column(
              children: [
                SizedBox(height: 15,),
                FutureBuilder(
                  future: fetchedUser,
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if(snapshot.hasData) {

                      return InkWell(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilScreen()));
                        },
                        child: ListTile(
                          leading: MenuWidget(),
                          title: Text(
                            "Welcome",style: kNonActiveTabStyle,textAlign: TextAlign.end,
                          ),
                          subtitle: Text(
                            fullname,
                            textAlign: TextAlign.end,
                            style: kActiveTabStyle,

                          ),
                          trailing: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: true ? NetworkImage(profilPic) : AssetImage('assets/images/footnews1.png') as ImageProvider,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ),
                      );


                    }
                    else {
                      return const Center(

                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: kGrey1,
                    unselectedLabelStyle: kNonActiveTabStyle,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelStyle: kActiveTabStyle.copyWith(fontSize: 22),
                    tabs: [
                      Tab(text: "Popular",),
                      Tab(text: "Trending",),
                      Tab(text: "Recent",),

                    ],
                  ),
                )
              ],
            ),
          ):null,
          body: screens[index]

        ));
  }
}
