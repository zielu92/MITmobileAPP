import 'package:flutter/material.dart';
import 'package:mitapp/Screen/categories.dart';
import 'package:mitapp/Screen/home.dart';
import 'package:mitapp/Screen/login.dart';
import 'package:mitapp/Screen/mainLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
    return Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.6],
              colors: [
                Color(0xFF8dc63f),
                Color(0xFF1fade5),
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Screens', style: TextStyle(fontSize: 35.0),),
                  FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          left: 10,
                          right: 10),
                      child: Text(
                        'Login',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    color: Color(0xFF8dc63f),
                    disabledColor: Colors.grey,
                    shape: new RoundedRectangleBorder(
                        borderRadius:
                        new BorderRadius.circular(20.0)),
                    onPressed: _mainLogin,
                  ),
                  FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          left: 10,
                          right: 10),
                      child: Text(
                        'Categories',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    color: Color(0xFA8d2640),
                    disabledColor: Colors.grey,
                    shape: new RoundedRectangleBorder(
                        borderRadius:
                        new BorderRadius.circular(20.0)),
                    onPressed: _categories,
                  ),
                  FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 10,
                          right: 10),
                      child: Text(
                        'Add New product',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    color: Color(0xFF8dc63f),
                    disabledColor: Colors.grey,
                    shape: new RoundedRectangleBorder(
                        borderRadius:
                        new BorderRadius.circular(20.0)),
                    onPressed: null,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  void _mainLogin() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MainLogin()));
  }

  void _categories() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Categories()));
  }
}
