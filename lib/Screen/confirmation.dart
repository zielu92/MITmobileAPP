import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';
import 'package:mitapp/Screen/thanks.dart';
import 'package:mitapp/main.dart';
//Anan Part
class Confirmation extends StatefulWidget {
  final int id;
  final String name;
  final String price;
  Confirmation(this.id, this.name, this.price);
  @override
  _ConfirmationState createState() => _ConfirmationState(this.id, this.name, this.price);
}

class _ConfirmationState extends State<Confirmation> {
  final int id;
  final String name;
  final String price;
  _ConfirmationState(this.id, this.name, this.price);

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(shrinkWrap: true, children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Stack(children: [
            Stack(children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: double.infinity,
              ),
              Container(
                height: 250.0,
                width: double.infinity,
                color: Color(0xFFFDD149),
              ),
              Positioned(
                bottom: 450.0,
                right: 100.0,
                child: Container(
                  height: 400.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Color(0xFFFEE16D),
                  ),
                ),
              ),
              Positioned(
                bottom: 500.0,
                left: 150.0,
                child: Container(
                    height: 300.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150.0),
                        color: Color(0xFFFEE16D).withOpacity(0.5))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: IconButton(
                    alignment: Alignment.topLeft,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
              ),
              Positioned(
                  top: 50.0,
                  left: 15.0,
                  child: Text(
                    'Confirm your order',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  )),
              Positioned(
                  top: 105.0,
                  left: 15.0,
                  child: Text(
                    'Address : 2 Road 2 soi 8 BKK Thailand 1019',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal),
                  )),
              Positioned(
                top: 150.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.lightGreenAccent,
                      width: double.maxFinite,
                      height: 200,
                      child: Card(

                        child: ListTile(
                          leading: Icon(Icons.toys, size: 50),
                          title: Text(name),
                          subtitle: Text(price+" ฿"),
                        ),
                      ),
                    ),
//                    itemCard(
//                        'Hand Woven Silk Fabric', 'Color : Pink,Red,Yellow',
//                        '1500',
//                        'assets/silk.jpg', true, 0)
                  ],
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(top: 350.0, bottom: 15.0),
                  child: Container(
                      height: 50.0,
                      width: double.infinity,
                      color: Colors.greenAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Product price : ' + price +
                              ' Bath'),
                          SizedBox(width: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                          )
                        ],
                      ))),

              Padding(
                  padding: EdgeInsets.only(top: 400.0, bottom: 15.0),
                  child: Container(
                      height: 50.0,
                      width: double.infinity,
                      color: Colors.greenAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Donation amount (10%) : ' + donationMoney() + ' Bath'),
                          SizedBox(width: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                          )
                        ],
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 450.0, bottom: 15.0),
                  child: Container(
                      height: 50.0,
                      width: double.infinity,
                      color: Colors.lightGreenAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Price include VAT (7%) : ' + tax() + ' Bath'),
                          SizedBox(width: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {},
                              elevation: 0.5,
                              color: Colors.greenAccent,
                              child: Center(
                                child: FlatButton(
                                  child: Text(
                                    _isLoading ? 'Ordering...' : 'Confirm order',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  color: Colors.greenAccent,
                                  onPressed: _order,
                                ),
                              ),
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ))),
            ])
          ])
        ])
      ]),
    );
  }

  String donationMoney() {
    double base = double.parse(price);
    return (base * 0.1).round().toString();
  }

  String tax() {
    double base = double.parse(price);
    return (base * 0.07).round().toString();
  }

  void _order() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'product_id': id,
      'user_id': '1'
    };

    var res = await CallApi().postData(data, 'order');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] != null) {
      if (body['success']) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => Thanks()));
      }
    }
  }
}

