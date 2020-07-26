import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';
import 'package:mitapp/Screen/editProfile.dart';
import 'package:mitapp/Screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });

  }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  Center(
//                    child: Image.asset("assets/logo-retina.png",
//                      scale: 2,),
//                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  ////////////// 1st card///////////
                  Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 40, bottom: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(child: Text('Welcome '+userData['name'])),
                          Center(child: Text('HOME SCREEN')),
                        ],
                      ),
                    ),
                  ),

                  /////////////// Button////////////
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /////////// Edit Button /////////////
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FlatButton(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8, bottom: 8, left: 10, right: 10),
                              child: Text(
                                'Edit Profile',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            color: Colors.blue,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            onPressed: _editProfile,
                          ),
                        ),

                        ////////////// logout//////////

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FlatButton(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Text(
                                  'Logout',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              color: Colors.red,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0)),
                              onPressed: _logout
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),      bottomNavigationBar:BottomNavigationBar(
      currentIndex: _cIndex,
      type: BottomNavigationBarType.shifting ,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.phone,color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text('Telefony')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.notification_important,color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text('Powiadomienia')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.verified_user,color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text('Klienci')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm,color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text('Inne')
        )
      ],
      onTap: (index){
        _incrementTab(index);
      },
    )
    );
  }

  void _editProfile() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Edit()));
  }
  void _logout() async{
    // logout from the server ...
    var res = await CallApi().getDataWithToken('logout');
    var body = json.decode(res.body);
    //print(body);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => LogIn()));


  }


}
