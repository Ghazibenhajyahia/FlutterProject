import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportpal/Service/PlayerService.dart';
import 'package:sportpal/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';




class CompleteProfilTennisPage extends StatefulWidget {
  const CompleteProfilTennisPage({Key? key}) : super(key: key);

  @override
  _CompleteProfilTennisPageState createState() => _CompleteProfilTennisPageState();
}

class _CompleteProfilTennisPageState extends State<CompleteProfilTennisPage> {
  final myController = TextEditingController();
  var court ="";
  var strong ="";
  var knowledge ="";
  var idol ="";
  late Future<bool> fetchedUser;
  late SharedPreferences prefs;
  late String id;
  late String idSport;

  Future<bool> fetchUser() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("_id")!;
    idSport = prefs.getString("typeSport")!;
    return true;
  }

  @override
  void initState() {
    fetchedUser = fetchUser();
    super.initState();
  }
  List<String> chipListCourt = [
    "grass",
    "clay",
    "Hard",
  ];

  List<String> chipListHanded = [
    "Left Handed",
    "Right Handed",
  ];

  List<String> chipListRules = [
    "Coach",
    "Player",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchedUser,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: SingleChildScrollView(
                  child: Container(
                    width: 350,
                    height: 580,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          //color: new Color(0xffffc107),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: themeColor,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.sports_tennis),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'Complete info ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Icon(Icons.sports_tennis)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.only(top: 9),
                            child: Text(
                              'Select your favourite court',
                              style: TextStyle(color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                        ),

                        Container(
                            child: Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: <Widget>[
                                SizedBox(height: 20,),
                                choiceChipWidget(chipListCourt,court),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Select your strong Hand',
                              style: TextStyle(color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                        ),

                        Container(
                            child: Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: <Widget>[
                                SizedBox(height: 20,),
                                choiceChipWidget(chipListHanded,strong),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Are you a ?',
                              style: TextStyle(color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                        ),

                        Container(
                            child: Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: <Widget>[
                                SizedBox(height: 20,),
                                choiceChipWidget(chipListRules,knowledge),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Enter your Idol Player',
                              style: TextStyle(color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                        ),
                        Container(
                            child:TextField(
                              controller: myController,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            child: RaisedButton(
                                color: themeColor,
                                child: new Text(
                                  'Done',
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: ()async {
                                  myController.text;
                                  print("hedha strong : "+strong);
                                  var resultat = await PlayerService().completeProfil(idSport, "", strong, court, knowledge, idol, id);
                                  print(resultat);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;
  var  choice;

  choiceChipWidget(this.reportList, this.choice);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: tennisColorSecondary,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {

              selectedChoice = item;
              widget.choice = selectedChoice;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
