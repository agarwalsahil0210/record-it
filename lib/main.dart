import 'package:flutter/material.dart';
import 'package:record_it/pages/homePage.dart';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:record_it/pages/PlayVideoPage.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RECORD IT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
