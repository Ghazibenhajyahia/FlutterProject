import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late int _id;
  late SharedPreferences prefs;

  final String _baseUrl = "10.0.2.2:3002";
  late Future<SandwichData> fetchedSandwich;

  Future<SandwichData> fetchSandwich() async {
    prefs = await SharedPreferences.getInstance();
    _id = prefs.getInt("id")!;


    final response =
    await http.get(Uri.http(_baseUrl, "/api/sandwish/" + _id.toString()));

    if (response.statusCode == 200) {
      print('200 houni'+SandwichData.fromJson(jsonDecode(response.body)).toString());
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return SandwichData.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Sandwich');
    }
  }

  @override
  void initState() {
    fetchedSandwich = fetchSandwich();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
        backgroundColor: Colors.white,
        title: const Text(
          "Details",
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
      body: FutureBuilder<SandwichData>(
        future: fetchedSandwich,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              child: ListView(
                children: [
                  Image.network("http://10.0.2.2:3002/" + snapshot.data!.image,
                      width: 400, height: 400),
                  Text(
                    snapshot.data!.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    snapshot.data!.prix.toString()+" DT ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    snapshot.data!.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class SandwichData {
  final int id;
  final String image;
  final String title;
  final String description;
  final double prix;

  SandwichData(
      {required this.id,
      required this.image,
      required this.title,
      required this.description,
      required this.prix});

  @override
  String toString() {
    return 'SandwichData{id: $id, image: $image, title: $title, description: $description, prix: $prix}';
  }

  factory SandwichData.fromJson(Map<String, dynamic> json) {
    return SandwichData(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      prix: json['prix'],
    );
  }
}
