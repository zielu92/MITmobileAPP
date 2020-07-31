import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';
import 'package:mitapp/Screen/Category.dart';
import 'package:mitapp/Screen/addProduct.dart';
import 'package:mitapp/Screen/mainLogin.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<List<SingleCategory>> _getCategories() async {
    var data = await CallApi().getDataWithoutToken('categories');
    var jsonData = json.decode(data.body);
    List<SingleCategory> categories = [];

    for (var n in jsonData) {
      SingleCategory singleCategory =
          SingleCategory(n["id"], n["name"], n["photo"]["path"]);
      categories.add(singleCategory);
    }

    print(categories.length);

    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            appBar(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Support locals and buy local", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getCategories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(child: Text("Loading Categories...")),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              leading: Image.network(
                                  snapshot.data[index].fullPath()),
                              title: Text(snapshot.data[index].name.toString()),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (conext) => Category(
                                            snapshot.data[index].id,
                                            snapshot.data[index].name)));
                              },
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => AddNewProduct()));
        },
        child: Icon(Icons.add_circle),
        backgroundColor: Colors.green,
      ),

    );
  }

  Widget appBar() {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width:50.0),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  "MIT App",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.supervised_user_circle, color: Colors.black),
            onPressed: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => MainLogin())),
          ),
        ],
      ),
    );
  }
}

class SingleCategory {
  final int id;
  final String name;
  final String icon;

  var URL = "http://zielu922.vot.pl";
  SingleCategory(this.id, this.name, this.icon);

  String fullPath() {
    return URL + icon;
  }
}
