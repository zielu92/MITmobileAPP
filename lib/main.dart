import 'package:flutter/material.dart';
import 'package:mitapp/Screen/categories.dart';
import 'package:mitapp/Screen/home.dart';
import 'package:mitapp/Screen/login.dart';
import 'package:mitapp/Screen/mainLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screen/addProduct.dart';


void main() {
  runApp(MaterialApp(
    home: new MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Categories();
  }


}
