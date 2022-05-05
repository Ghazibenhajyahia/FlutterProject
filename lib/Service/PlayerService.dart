
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportpal/Model/User.dart';

import '../Model/Player.dart';
import '../constants.dart';

class PlayerService{

  final String _baseUrl = serverLocalhost+":3000";


  Future<String?> updateProfilPlayer(fullname, email, age, telnum, filepath, id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('PATCH', Uri.http(_baseUrl, "/player/" + id));

    if (fullname.toString().isNotEmpty) {
      request.fields['fullName'] = fullname;
    }
    if (email.toString().isNotEmpty) {
      request.fields['email'] = email;
    }
    if (age.toString().isNotEmpty) {
      request.fields['birthDate'] = age;
    }
    if (telnum.toString().isNotEmpty) {
      request.fields['telNum'] = telnum;
    }
    if (filepath != null) {
      request.files.add(await http.MultipartFile.fromPath('picture', filepath));
    }
    var res = await request.send();
    var responsed = await http.Response.fromStream(res);
    final userData = json.decode(responsed.body);
    if (res.statusCode == 200) {
      User u = User.fromJson(userData["user"]);

      Map<String, dynamic> test = u.toMap();
      test.forEach((String key, dynamic value) {
        print(key);
        print(value);
        if (value == false || value == true) {
          prefs.setBool(key, value);
        }else if (value is List){
          value.forEach((element) {
            prefs.setString("longtitude", element);
            prefs.setString("laltitude", element);
          });
        }
        else if (value != null) {
            prefs.setString(key, value);
        } else {
          prefs.setString(key, "");
        }
      });

      return await Future(() => "updated");
    } else if (res.statusCode == 400) {
      return await Future(() => "error");
    }
    return res.reasonPhrase;
  }

  Future<List<Player>?> getAllPlayers(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    final List<Player> players = [];

    final test = await http.get(Uri.http(_baseUrl, "/player/"+id), headers: headers)
        .then((http.Response response) async {
      if(response.statusCode == 404){

      }
      else if(response.statusCode == 200) {
        List<dynamic> userData = await  json.decode(response.body)['players'];
        for(int i = 0; i < userData.length; i++) {
          players.add(Player(userData[i]['team'],userData[i]['team'],userData[i]['rating'],
            userData[i]['description'],userData[i]['_id'],userData[i]['fullName'],userData[i]['email'],
            userData[i]['password'],userData[i]['telNum'],userData[i]['profilePic'],userData[i]['isVerified'],
            userData[i]['address'],userData[i]['birthDate'],userData[i]['gender'],userData[i]['type'],userData[i]['friends']));
        }

        return players;
      }
      else if(response.statusCode == 401) {
        return players;
      }
    }
    );
    return players;

  }

  Future<List<Player>?> getFriends(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    final List<Player> players = [];

    final test = await http.delete(Uri.http(_baseUrl, "/player/friends/"+id), headers: headers)
        .then((http.Response response) async {
      if(response.statusCode == 404){

      }
      else if(response.statusCode == 200) {

        List<dynamic> userData = await  json.decode(response.body)['players'];
        print(userData);
        for(int i = 0; i < userData.length; i++) {
          players.add(Player(userData[i]['team'],userData[i]['team'],userData[i]['rating'],
              userData[i]['description'],userData[i]['_id'],userData[i]['fullName'],userData[i]['email'],
              userData[i]['password'],userData[i]['telNum'],userData[i]['profilePic'],userData[i]['isVerified'],
              userData[i]['address'],userData[i]['birthDate'],userData[i]['gender'],userData[i]['type'],userData[i]['friends']));
        }

        return players;
      }
      else if(response.statusCode == 401) {
        return players;
      }
    }
    );
    return players;

  }

  Future<String?> completeProfil(sports,strongLeg,strongHand,favCourt,knowledge,idol,id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('PATCH', Uri.http(_baseUrl, "/player/" + id));

    if (sports.toString().isNotEmpty) {
      request.fields['sports'] = sports;
    }
    if (strongLeg.toString().isNotEmpty) {
      request.fields['strongLeg'] = strongLeg;
    }
    if (strongHand.toString().isNotEmpty) {
      request.fields['strongHand'] = strongHand;
    }
    if (favCourt.toString().isNotEmpty) {
      request.fields['favCourt'] = favCourt;
    }if (knowledge.toString().isNotEmpty) {
      request.fields['knowledge'] = knowledge;
    }if (idol.toString().isNotEmpty) {
      request.fields['idol'] = idol;
    }

    print(request.fields);
    var res = await request.send();
    var responsed = await http.Response.fromStream(res);
    final userData = json.decode(responsed.body);
    if (res.statusCode == 200) {
      // Player u = Player.fromJson(userData["user"]);
      //
      // Map<String, dynamic> test = u.toMap();
      //
      // test.forEach((String key, dynamic value) {
      //   print(key);
      //   print(value);
      //   if (value == false || value == true) {
      //     prefs.setBool(key, value);
      //   }else if (value is List){
      //     value.forEach((element) {
      //       prefs.setString("longtitude", element);
      //       prefs.setString("laltitude", element);
      //     });
      //   }
      //   else if (value != null) {
      //     prefs.setString(key, value);
      //   } else {
      //     prefs.setString(key, "");
      //   }
      // });

      return await Future(() => "updated");
    } else if (res.statusCode == 400) {
      return await Future(() => "error");
    }
    return res.reasonPhrase;
  }

}