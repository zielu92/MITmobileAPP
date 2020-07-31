import 'package:flutter/material.dart';
import 'package:mitapp/main.dart';

class Thanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xFF1fade5),
          title: Text(
            "Thank You for purchase",
          ),
          actions: <Widget>[],
        ),
        backgroundColor: Color(0xFF1fade5),
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Icon(Icons.favorite, size: 200, color: Colors.red,),
                Text('Thank You',
                    style: TextStyle(
                      fontFamily: 'Amatic',
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                Text('Your total donations: 530 ฿',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0,
                      color: Colors.grey[300],
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    )),
                Text('with your support world is much more wonderful',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 15.0,
                      color: Colors.grey[400],
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.indigo.shade100,
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    return Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MyApp()));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(Icons.arrow_forward_ios, color: Colors.grey[800]),
                      title: Text(
                        'Check out other products',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: 'SourceSansPro',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.indigo.shade100,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
