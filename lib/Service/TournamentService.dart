import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportpal/Model/Complexe.dart';
import 'package:sportpal/Model/Tournament.dart';
import 'package:sportpal/Model/User.dart';

import '../Model/Matche.dart';
import '../Model/News.dart';
import '../Model/Participant.dart';
import '../Model/Team.dart';
import '../constants.dart';
import '../main.dart';

class TournamentService{

  final String _baseUrl = serverLocalhost+":3000";


  Future <bool> getTournament(List <Tournament> listTournament ) async {

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    final test = await http.get(Uri.http(_baseUrl, "/tournament/"), headers: headers)
        .then((http.Response response) async {
      List<dynamic> tournamentData = await  json.decode(response.body);
      for(int i = 0; i < tournamentData.length; i++) {
        /* var participants = tournamentData[i]["participants"] as List;
        print(participants.length);
        List<Participant> participantsList = participants.map((x) => Participant.fromJson(x)).toList();
        var matches = tournamentData[i]['matchs']as List;*/
        //var user = tournamentData[i]['owner'] as User;
        /*var team = tournamentData[i]['winner'] as Team;
        var complexe = tournamentData[i]['place'] as Complexe;
        List<Matche> matcheslist = matches.map((x) => Matche.fromJson(x)).toList();*/
        /*listTournament.add(Tournament(tournamentData[i]["_id"], tournamentData[i]["title"], tournamentData[i]["typeSport"],  tournamentData[i]["type"],tournamentData[i]["numberOfParticipants"],
            user,participantsList,matcheslist,team,tournamentData[i]["prize"],tournamentData[i]["from"],tournamentData[i]["to"],
            complexe));*/
        listTournament.add(Tournament(tournamentData[i]["_id"],tournamentData[i]["title"],tournamentData[i]["typeSport"],tournamentData[i]["type"],tournamentData[i]["numberOfParticipants"],null,null,null,null,tournamentData[i]["prize"],null,null,null));

      }
      if(response.statusCode == 200) {
        return await Future(() => listTournament);
      }});

    return true;

  }



}