import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';
import 'package:mitapp/Screen/Category.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Categories"),
      ),
      body: Container(
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
                    return ListTile(
                      leading: Image.network(snapshot.data[index].fullPath()),
                      title: Text("ID: " + snapshot.data[index].id.toString()),
                      subtitle: Text(snapshot.data[index].name),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (conext) => Category(
                                    snapshot.data[index].id,
                                    snapshot.data[index].name)));
                      },
                    );
                  });
            }
          },
        ),
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
