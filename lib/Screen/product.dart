import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';
import 'package:mitapp/Screen/addProduct.dart';
import 'package:mitapp/Screen/confirmation.dart';
import 'package:mitapp/Screen/mainLogin.dart';

class Product extends StatefulWidget {
  final int id;
  final String name;
  final String categoryName;
  Product(this.id, this.name, this.categoryName);
  @override
  _ProductState createState() =>
      _ProductState(this.id, this.name, this.categoryName);
}

class _ProductState extends State<Product> {
  final int id;
  final String name;
  final String categoryName;
  _ProductState(this.id, this.name, this.categoryName);

  Future<SingleProduct> _getProductDetails() async {
    var data = await CallApi().getDataWithoutToken('product/' + id.toString());
    var jsonData = json.decode(data.body);
    jsonData = jsonData[0];
    SingleProduct product = SingleProduct(
      jsonData["id"],
      jsonData["title"],
      jsonData["photo"][0]["path"],
      jsonData["price"].toString(),
      jsonData["description"],
      jsonData["created_at"].toString(),
    );
    return product;
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
                  future: _getProductDetails(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(child: Text("Loading Product...")),
                      );
                    } else {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Flexible(
                                child: Image.network(snapshot.data.fullPath())),
                            SizedBox(height: 20),
                            //Center Items
                            Text('Price: ' + snapshot.data.price + " B"),
                            Text('Be a real hero!', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Buying this product " +
                                snapshot.data.donationMoney() +
                                " B is a donation for poor kinds"),
//                      Expanded(
//                        child: Text(snapshot.data.description),
//                      ),
                            FlatButton(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Text(
                                  'Buy product now and support others',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              color: Color(0xFF8dc63f),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (conext) => Confirmation(
                                            snapshot.data.id,
                                            snapshot.data.name,
                                            snapshot.data.price)));
                              },
                            ),

                            Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(snapshot.data.description),
                                )),
                          ],
                        ),
                      );
                    }
                  }),
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
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),
                ),
                Text(
                  categoryName,
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

class SingleProduct {
  final int id;
  final String name;
  final String photo;
  //can be convert into integer/long/decimal later;
  final String price;
  final String description;
  final String created_at;

  var URL = "http://zielu922.vot.pl";
  SingleProduct(this.id, this.name, this.photo, this.price, this.description,
      this.created_at);

  String fullPath() {
    return URL + photo;
  }

  String donationMoney() {
    double base = double.parse(price);
    return (base * 0.1).round().toString();
  }

  void viewsUpdate() {}
}
