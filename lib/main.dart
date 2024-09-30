import 'package:flutter/material.dart';
import 'package:app_store/pages/home.dart'; // Reference to the styled HomePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Use 'Poppins' font family for consistent styling
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Navigate to the HomePage
    );
  }
}
