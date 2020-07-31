import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';
import 'package:mitapp/Screen/addProduct.dart';
import 'package:mitapp/Screen/mainLogin.dart';
import 'package:mitapp/Screen/product.dart';

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

  Future<List<ProductList>> _getProducts() async {
    var data = await CallApi().getDataWithoutToken('category/' + id.toString());
    var jsonData = json.decode(data.body);
    List<ProductList> products = [];

    for (var n in jsonData) {
      ProductList singleProduct = ProductList(
          n["id"], n["title"], n["photo"][0]["path"], n["price"].toString());
      products.add(singleProduct);
    }

    print(products.length);

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            appBar(),
            Expanded(
              child: FutureBuilder(
                future: _getProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(child: Text("Loading products...")),
                    );
                  } else {
                    if (snapshot.data.length > 0) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                    snapshot.data[index].fullPath()),
                                title: Text(snapshot.data[index].name),
                                subtitle: Text(snapshot.data[index].price+" ฿ Buying it you are donating "+ snapshot.data[index].donationMoney() +" ฿ "),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (conext) => Product(
                                              snapshot.data[index].id,
                                              snapshot.data[index].name,
                                              name)));
                                },
                              ),
                            );
                          });
                    } else {
                      return Center(
                          child: Text(
                        "No products",
                        style: TextStyle(fontSize: 30.0),
                      ));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AddNewProduct()));
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
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  name,
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
            onPressed: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => MainLogin())),
          ),
        ],
      ),
    );
  }
}

class ProductList {
  final int id;
  final String name;
  final String photo;
  final String price;

  var URL = "http://zielu922.vot.pl";
  ProductList(this.id, this.name, this.photo, this.price);

  String donationMoney() {
    double base = double.parse(price);
    return (base * 0.1).round().toString();
  }

  String fullPath() {
    return URL + photo;
  }
}
