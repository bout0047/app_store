import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  final String _baseUrl = 'http://localhost:5106/api/Apps'; // Update with your backend URL

  Future<List<App>> fetchApps() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> appListJson = json.decode(response.body);
      return appListJson.map((json) => App.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load apps');
    }
  }
}

class App {
  final int id;
  final String name;
  final String description;

  App({required this.id, required this.name, required this.description});

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
