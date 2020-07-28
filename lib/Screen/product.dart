import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';

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
        jsonData["description"]);
    return product;
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
            future: _getProductDetails(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                // ignore: missing_return
                return Container(
                  child: Center(child: Text("Loading Product...")),
                );
              } else {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Image.network(snapshot.data.fullPath()),
                      SizedBox(height: 20),
                      //Center Items
                      Text('Price: '+ snapshot.data.price +" B"),
                      Text("Where "+ snapshot.data.donationMoney() +" B is a donation for poor kinds" ),
                      Expanded(
                        child: Text(snapshot.data.description),
                      ),
                    ],
                  ),
                );
              }
            }),
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

  var URL = "http://zielu922.vot.pl";
  SingleProduct(this.id, this.name, this.photo, this.price, this.description);

  String fullPath() {
    return URL + photo;
  }

  String donationMoney() {
    double base = double.parse(price);
    return (base*0.01).round().toString();
  }
}
