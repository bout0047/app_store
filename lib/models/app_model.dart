// lib/models/app_model.dart
class AppModel {
  final int appId;
  final String name;
  final String description;
  final double price;
  final String iconPath; 
  final int categoryId; // Add this property
  final double rating; // Add this property

  AppModel({
    required this.appId,
    required this.name,
    required this.description,
    required this.price,
    required this.iconPath,
    required this.categoryId, // Include this in constructor
    required this.rating, // Include this in constructor
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      appId: json['appId'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      iconPath: json['iconPath'],
      categoryId: json['categoryId'], // Parse from JSON
      rating: json['rating'].toDouble(), // Parse from JSON
    );
  }
}

