import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mitapp/Controller/api.dart';
import 'package:mitapp/main.dart';

class Confirmation extends StatefulWidget {
  final int id;
  final String name;
  Confirmation(this.id, this.name);
  @override
  _ConfirmationState createState() => _ConfirmationState(this.id, this.name);
}

class _ConfirmationState extends State<Confirmation> {
  final int id;
  final String name;
  _ConfirmationState(this.id, this.name);

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Confirmation page"),
      ),
      body: Container(
        child: Center(
          child:                       FlatButton(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 8, bottom: 8, left: 10, right: 10),
              child: Text(
                _isLoading ? 'Ordering...' : 'Confirm order',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            color: Color(0xFF8dc63f),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            onPressed: _order,
          ),
        ),
      ),
    );
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
                builder: (context) => MyApp()));
      }
    }
  }
}
