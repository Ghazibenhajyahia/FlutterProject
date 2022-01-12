import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late String? _username;
  late String? _password;

  final String _baseUrl = "10.0.2.2:3002";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _keyForm,
      child: ListView(
        children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Image.asset("assets/images/logo.png",
                  width: 460, height: 215)),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Username"),
                onSaved: (String? value) {
                  _username = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Le username ne doit pas etre vide";
                  } else if (value.length < 5) {
                    return "Le username doit avoir au moins 5 caractères";
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "password"),
                onSaved: (String? value) {
                  _password = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Le password ne doit pas etre vide";
                  } else if (value.length < 5) {
                    return "Le password doit avoir au moins 5 caractères";
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(150, 20, 150, 0),
              child: ElevatedButton(
                child: const Text(
                  "Login",
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.yellow),
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    _keyForm.currentState!.save();

                    Map<String, dynamic> userData = {
                      "username": _username,
                      "password": _password
                    };

                    Map<String, String> headers = {
                      "Content-Type": "application/json; charset=UTF-8"
                    };
                    http
                        .post(Uri.http(_baseUrl, "/api/login"),
                            headers: headers, body: json.encode(userData))
                        .then((http.Response response) async {
                      if (response.statusCode == 200) {
                        Map<String, dynamic> userData =
                            json.decode(response.body);
                        print("JAWEK NICE !");

                        // SharedPreferences
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.setInt("userId", userData["id"]);

                        prefs.setString("username", userData["username"]);

                        // SQFLite

                        Navigator.pushNamed(context, "/sandwich");
                      } else if (response.statusCode == 401) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Information"),
                              content: Text(
                                  "Username et/ou mot de passe incorrect !"),
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Information"),
                              content: Text(
                                  "Une erreur s'est produite, veuillez réessayer plus tard !"),
                            );
                          },
                        );
                      }
                    });
                  }
                },
              ))
        ],
      ),
    ));
  }
}
