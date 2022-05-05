
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportpal/Model/Complexe.dart';
import 'package:sportpal/Model/Matche.dart';
import 'package:sportpal/Model/Team.dart';
import 'package:sportpal/Model/Terrain.dart';

import '../Model/Player.dart';
import '../constants.dart';

class MatchService{

  final String _baseUrl = serverLocalhost+":3000";

  Future<List<Matche>?> getMatchs(String idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    final List<Matche> matchs = [];


    final test = await http.get(Uri.http(_baseUrl, "/match/"+idUser), headers: headers)
        .then((http.Response response) async {
          if(response.statusCode == 200) {

        List<dynamic> matchData = await  json.decode(response.body);

        //List<Match> users = [];

        for(int i = 0; i < matchData.length; i++) {
          var lista = matchData[i]['teamA']['players'] as List;
          var listb = matchData[i]['teamB']['players'] as List;

          print( matchData.length);
          List<Player> imagesListA = lista.map((x) => Player.fromJson(x)).toList();
          List<Player> imagesListB = listb.map((x) => Player.fromJson(x)).toList();

          Team teamA   = Team(matchData[i]['teamA']['_id'],imagesListA,imagesListA[0],"","","","");
          Team teamB   = Team(matchData[i]['teamB']['_id'],imagesListB,imagesListB[0],"","","","");
          Terrain terrain   = Terrain(matchData[i]['terrain']['_id'],matchData[i]['terrain']['complexe'],matchData[i]['terrain']['typeSport'],
              matchData[i]['terrain']['picture'],matchData[i]['terrain']['name'],matchData[i]['terrain']['location'],matchData[i]['terrain']['rating']);

            matchs.add(Matche(matchData[i]['_id'],teamA,teamB,matchData[i]['winner'],matchData[i]['date'],matchData[i]['time'],terrain,matchData[i]['arbitre'],matchData[i]['scoreA'],matchData[i]['scoreB']));

      }

        return matchs;
    } else if(response.statusCode == 500) {
            return matchs;
          }
    }
    );

    return null;

  }

  Future <bool> createIndivMatch(String teamA,String teamB, DateTime date,String terrain,String notifId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    String datee = DateFormat("yyyy-MM-dd").format(date);
    String time = DateFormat.jms().format(date);
    Map<String,dynamic> body = {
      "teamA": teamA,
      "teamB": teamB,
      "date": datee,
      "time": time,
      "id": notifId,
      "terrain": terrain
    };

    print(body);

    final test = await http.post(Uri.http(_baseUrl, "/match/indivMatch"), headers: headers,body: json.encode(body))
        .then((http.Response response) async {
          print(response.body.toString());
      if (response.statusCode == 201) {
      }
      // print("ena body"+response.body);
      // List<dynamic> complexeData = await  json.decode(response.body);
      // print(complexeData);
      // for(int i = 0; i < complexeData.length; i++) {
      //   //Map<String, dynamic> userData = newsData[i];
      //   //print(await newsData[i]["imageURL"]);
      //   var list = complexeData[i]['terrains']as List;
      //   print(list.length);
      //   //print("holle"+list.runtimeType.toString());
      //
      //   List<Terrain> terrainList = list.map((x) => Terrain.fromJson(x)).toList();
      //   print(terrainList);
      //   listComplexe.add(Complexe(complexeData[i]["_id"], complexeData[i]["owner"], terrainList,  complexeData[i]["address"],complexeData[i]["name"],complexeData[i]["picture"]));
      //
      // }
      // if(response.statusCode == 200) {
      //
      //   return await new Future(() => listComplexe);
      // }});
    });
    return true;

  }





}