import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';

class Category extends StatefulWidget {
  final int id;
  final String name;
  Category(this.id, this.name);
  @override
  _CategoryState createState() => _CategoryState(this.id, this.name);
}

class _CategoryState extends State<Category> {
  final int id;
  final String name;
  _CategoryState(this.id, this.name);

  Future<List<Product>> _getProducts() async {
    var data = await CallApi().getDataWithoutToken('category/' + id.toString());
    var jsonData = json.decode(data.body);
    List<Product> products = [];

    for (var n in jsonData) {
      print(jsonData);
      Product singleProduct = Product(n["id"], n["title"], n["photo"][0]["path"], n["price"].toString());
      products.add(singleProduct);
    }

    print(products.length);

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(name),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(child: Text("Loading Category...")),
              );
            } else {
              if (snapshot.data.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(snapshot.data[index].fullPath()),
                        title: Text("Price: " + snapshot.data[index].price),
                        subtitle: Text(snapshot.data[index].name),
                        onTap: () {
                          //    Navigator.push(
                          //    context,
                          //    new MaterialPageRoute(
                          //    builder: (conext) =>
                          //    Details(snapshot.data[index])));
                        },
                      );
                    });
              } else {
                return Center(child: Text("No products", style: TextStyle(fontSize: 30.0),));
              }
            }
          },
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String photo;
  final String price;

  var URL = "http://zielu922.vot.pl";
  Product(this.id, this.name, this.photo, this.price);

  String fullPath() {
    return URL + photo;
  }
}
