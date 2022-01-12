import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:revisionflutter/sadwich_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Sandwich extends StatefulWidget {
  const Sandwich({Key? key}) : super(key: key);

  @override
  _SandwichState createState() => _SandwichState();
}

class _SandwichState extends State<Sandwich> {
  late String? _username;
  late Future<String> fetchedUser;
  final List<SandwichData> _sandwichs = [];
  final String _baseUrl = "10.0.2.2:3002";
  late Future<bool> fetchedSandwichs;

  Future<bool> fetchSandiwchs() async {
    http.Response response =
        await http.get(Uri.http(_baseUrl, "/api/sandwish"));

    List<dynamic> sandwichsFromServer = json.decode(response.body);
    for (int i = 0; i < sandwichsFromServer.length; i++) {
      _sandwichs.add(SandwichData(
          sandwichsFromServer[i]["id"],
          sandwichsFromServer[i]["image"],
          sandwichsFromServer[i]["title"],
          sandwichsFromServer[i]["description"],
          sandwichsFromServer[i]["prix"]));
    }

    return true;
  }

  Future<String> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString("username");
    print("el user : " + _username!);

    return _username!;
  }

  @override
  void initState() {
    super.initState();
    fetchedUser = fetchUser().whenComplete(() {
      setState(() {});
    });
    fetchedSandwichs = fetchSandiwchs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.orange,
            ),
            onPressed: () {},
          )
        ],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
        backgroundColor: Colors.white,
        title: const Text(
          "Menu",
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
      body: FutureBuilder(
        future: fetchedSandwichs,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: _sandwichs.length,
              itemBuilder: (BuildContext context, int index) {
                return SandwichInfo(
                    _sandwichs[index].id,
                    _sandwichs[index].image,
                    _sandwichs[index].title,
                    _sandwichs[index].description,
                    _sandwichs[index].prix);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text(
                "Welcome MR . " + _username!,
              ),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.power_settings_new),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Deconnexion")
                ],
              ),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.pushNamed(context, "/");
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.shopping_cart),
                  SizedBox(
                    width: 20,
                  ),
                  Text(" My Cart")
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/sandwich");
              },
            ),
          ],
        ),
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

  SandwichData(this.id, this.image, this.title, this.description, this.prix);

  @override
  String toString() {
    return 'SandwichData{id: $id, image: $image, title: $title, description: $description, prix: $prix}';
  }
}
