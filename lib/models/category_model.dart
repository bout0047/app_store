// lib/models/category_model.dart

class CategoryModel {
  final int id; 
  final String name;
  final int boxColor; // Assuming this is an int for color representation
  final String iconPath; // Add this property

  CategoryModel({
    required this.id,
    required this.name,
    required this.boxColor,
    required this.iconPath, // Include this in constructor
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      boxColor: int.parse(json['boxColor']),
      iconPath: json['iconPath'], // Parse from JSON
    );
  }
}
