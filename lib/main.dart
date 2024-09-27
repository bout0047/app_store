import 'package:flutter/material.dart';
import 'package:app_store/pages/home.dart';

void main() {
  runApp(AppStore());
}

class AppStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
