import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class SaveImage extends StatefulWidget {
  @override
  _SaveImageState createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {
  var _medname = TextEditingController();
  var _medsearch = TextEditingController();
  Image imagefromstorage;
  final _picker = ImagePicker();

  Future getImage() async {
    final PickedFile image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        Utility.SaveImg(_medname.text,
            Utility.base64String(File(image.path).readAsBytesSync()));
      }
    });
  }

  loadImage(String medname) {
    Utility.GetImg(medname).then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imagefromstorage = Utility.imagefromBase64String(img);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: imagefromstorage == null
                  ? Text('No image found',
                      style: TextStyle(fontSize: 30, color: Colors.blue))
                  : imagefromstorage,
            ),
            SizedBox(
                height: 50,
                child: TextField(
                  controller: _medname,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                )),
            FlatButton(onPressed: getImage, child: Text('Add')),
            TextField(
              controller: _medsearch,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Search name'),
            ),
            FlatButton(
                onPressed: () {
                  loadImage(_medsearch.text);
                },
                child: Text('Search')),
          ],
        ),
      ),
    );
  }
}

class Utility {
  static Future<bool> SaveImg(String medname, String value) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.setString(medname, value);
  }

  static Future<String> GetImg(String medname) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(medname);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imagefromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String), fit: BoxFit.fill);
  }
}
