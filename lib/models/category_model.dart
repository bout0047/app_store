import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String iconPath;
  final Color boxColor;  // Change this to Color

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
        name: 'Games',
        iconPath: 'assets/icons/games.svg',
        boxColor: Color(0xFF9DCEFF),  // Use Color instead of int
      ),
      CategoryModel(
        name: 'Music',
        iconPath: 'assets/icons/music.svg',
        boxColor: Color(0xFF92A3FD),  // Use Color instead of int
      ),
      // Add more categories as needed
    ];
  }
}
