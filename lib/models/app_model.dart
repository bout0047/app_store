class AppModel {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final String categoryName;

  AppModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
    );
  }
}
