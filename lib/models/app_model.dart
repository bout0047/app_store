class AppModel {
  final int appID;
  final String name;
  final String category;
  final double rating;
  final String iconPath;

  AppModel({
    required this.appID,
    required this.name,
    required this.category,
    required this.rating,
    required this.iconPath,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      appID: json['appID'],
      name: json['name'],
      category: json['category'],
      rating: (json['rating'] as num).toDouble(),
      iconPath: json['iconPath'],
    );
  }
}

