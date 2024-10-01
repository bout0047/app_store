class Category {
  final int id;
  final String categoryName;
  final String iconPath;

  Category({
    required this.id,
    required this.categoryName,
    required this.iconPath,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      iconPath: json['iconPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'iconPath': iconPath,
    };
  }
}
