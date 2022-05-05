import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportpal/Controller/authentification/test.dart';

import '../Model/Player.dart';
import '../Model/Team.dart';
import '../constants.dart';

class TeamService {
  final String _baseUrl = serverLocalhost + ":3000";

  Future<List<Team>?> getTeams(String idUser) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    final List<Team> teams = [];


    final test = await http.get(Uri.http(_baseUrl, "/team/"+idUser), headers: headers)
        .then((http.Response response) async {
          if(response.statusCode == 200) {

        List<dynamic> teamData = await  json.decode(response.body);

        //List<Match> users = [];

        for(int i = 0; i < teamData.length; i++) {
          var list = teamData[i]['players']as List;
          List<Player> playerList = list.map((x) => Player.fromJson(x)).toList();
          Player player = Player.fromJson(teamData[i]['captain']);
          print(playerList);
         /* List<Player> imagesListA = lista.map((x) => Player.fromJson(x)).toList();
          List<Player> imagesListB = listb.map((x) => Player.fromJson(x)).toList();

          Team teamA   = Team(matchData[i]['teamA']['_id'],imagesListA,imagesListA[0],"");
          Team teamB   = Team(matchData[i]['teamB']['_id'],imagesListB,imagesListB[0],"");
          Terrain terrain   = Terrain(matchData[i]['terrain']['_id'],matchData[i]['terrain']['complexe'],matchData[i]['terrain']['typeSport'],
              matchData[i]['terrain']['picture'],matchData[i]['terrain']['name'],matchData[i]['terrain']['location'],matchData[i]['terrain']['rating']);
*/
            teams.add(Team(teamData[i]['_id'],playerList,player,teamData[i]['typeSport'],teamData[i]['picture'],teamData[i]['description'],teamData[i]['name']));

      }

        return teams;
    } else if(response.statusCode == 500) {
            return teams;
          }
    }
    );

    return teams ;

  }

  Future<String?> CreateTeam(idUser, filepath,name,description,typeSport) async {
    //
    var request = http.MultipartRequest('POST',Uri.http(_baseUrl,"/team/"+idUser));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (name.toString().isNotEmpty) {
      request.fields['players'] = idUser;
      request.fields['captain'] = idUser;
      request.fields['typeSport'] = typeSport;
      request.fields['picture'] = filepath;
      request.fields['description'] = description;
      request.fields['name'] = name;
    }


    if (filepath != null) {
      request.files.add(await http.MultipartFile.fromPath('picture', filepath));
    }
    print("Ena fields --------"+request.fields.toString());
    var response = await request.send();
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    print("Team -------------"+responseString.toString());
    Map<String, dynamic> team = await jsonDecode(responseString);

    if (response.statusCode == 201){


      /*Team t = Team.fromJson(team['newTeam']);*/

      /*Map<String,dynamic> test = t.toMap();
      print(test);
      test.forEach((key, value) {
        print(key);
        print(value);
        if(value == false || value == true){

          print(key+value);
         *//* prefs.setBool(key, value);*//*
        }else if (value is List){
          value.forEach((element) {
           *//* prefs.setString("longtitude", element);
            prefs.setString("laltitude", element);*//*
            print(element);
          });
        }else if (value != null){

        *//*  prefs.setString(key, value);*//*
        }else{
         *//* prefs.setString(key, "");*//*
        }
      });*/
      return await Future(() => "Team"/*prefs.getString("_id")*/);
    }else if (response.statusCode == 401){
      return await Future(() => "duplicated");
    }
    return response.reasonPhrase;
  }

  Future<Object> myTeam(String idTeam) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    final test = await http.get(Uri.http(_baseUrl, "/team/myteam/"+idTeam), headers: headers)
        .then((http.Response response) async {
      Map<String, dynamic> teamData = await  json.decode(response.body);
      if(response.statusCode == 200) {




        var list = teamData['myteam']['players']as List;

        print(list);
        List<Player> playerList = list.map((x) => Player.fromJson(x)).toList();
        Player player = Player.fromJson(teamData['myteam']['captain']);

        Team team = Team(teamData['myteam']['_id'],playerList,player,teamData['myteam']['typeSport'],teamData['myteam']['picture'],teamData['myteam']['description'],teamData['myteam']['name']);






        return team;
      }
      else if(response.statusCode == 401) {
        print(response.body);
        return await Future(() => "Have no Authorisation !");
      }else if(response.statusCode == 404) {
        print(response.body);
        return await Future(() => "Team no Team !");
      }

    }

    );
    return test!;

  }

/*Future<bool> createTeam(String idUser,XFile picture,String name,String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    *//*String datee = DateFormat("yyyy-MM-dd").format(date);
    String time = DateFormat.jms().format(date);*//*
    Map<String,dynamic> body = {
      "players": idUser,
      "capitain": idUser,
      "typeSport": "football",
      "picture": picture,
      "description": description
    };

    *//* print(body);*//*

    final test = await http
        .post(Uri.http(_baseUrl, "/team/" + idUser),  headers: headers,body: json.encode(body))
        .then((http.Response response) async {
      print(response.body.toString());
      if (response.statusCode == 201) {
        print(response.body);
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
*/

}
