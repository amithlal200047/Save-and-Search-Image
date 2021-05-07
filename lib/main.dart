import 'package:flutter/material.dart';
import 'package:image_saver/page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Image Saver',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SaveImage());
  }
}
