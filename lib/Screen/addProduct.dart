import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mitapp/Controller/api.dart';
import 'package:mitapp/main.dart';

TextEditingController title = TextEditingController();
TextEditingController price = TextEditingController();
TextEditingController description = TextEditingController();

class AddNewProduct extends StatefulWidget {
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  bool _isAdding = false;
  String dropdownValue = 'Test Category';

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8dc63f),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add new product"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            /////////////  background/////////////
            new Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.9],
                  colors: [
                    Color(0xFF8dc63f),
                    Color(0xFF1fade5),
                  ],
                ),
              ),
            ),

            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /////////////// name////////////

                            TextField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: title,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.create,
                                  color: Colors.grey,
                                ),
                                hintText: "Title",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.category,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.blueAccent),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blueAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Test Category',
                                    'Decoration',
                                    'Food',
                                    'Kitchenware',
                                    'Apparel'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),

                            TextField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: price,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                ),
                                hintText: "Price",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            /////////////// Email ////////////

                            TextField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: description,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.description,
                                  color: Colors.grey,
                                ),
                                hintText: "Description",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Center(
                              child: _image == null
                                  ? Text('No image selected.')
                                  : Image.file(
                                      _image,
                                      height: 200,
                                      width: 200,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      "Take photo",
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: Color(0xFF1fade5),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: getImage),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isAdding
                                          ? 'Adding...'
                                          : 'Add new product',
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
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: _handleAddProduct),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleAddProduct() async {
    setState(() {
      _isAdding = true;
    });
    var fileStream = new http.ByteStream(_image.openRead());
    var length = await _image.length();

    var request = http.MultipartRequest(
        'POST', Uri.parse("http://zielu922.vot.pl/api/auth/product"));
    request.fields['title'] = title.text;
    request.fields['price'] = price.text;
    request.fields['description'] = description.text;
    request.fields['user_id'] = "1";
    request.fields['category_id'] = "2";
    var multipartFile =
        new http.MultipartFile('photo', fileStream, length, filename: "htest");
    request.files.add(multipartFile);
    var res = await request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => MyApp()));
    });
  }
}
