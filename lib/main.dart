import 'package:flutter/material.dart';
import 'package:revisionflutter/details.dart';
import 'package:revisionflutter/sandwich.dart';
import 'package:revisionflutter/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (BuildContext context) {
          return const SignIn();
        },
        "/sandwich": (BuildContext context) {
          return const Sandwich();
        },
        "/details": (BuildContext context) {
          return const Details();
        }
      },
    );
  }
}
