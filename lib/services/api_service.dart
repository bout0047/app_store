import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://localhost:5000'; // Replace with your backend URL

  Future<List<App>> getApps() async {
    final response = await http.get(Uri.parse('$baseUrl/api/apps'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((app) => App.fromJson(app)).toList();
    } else {
      throw Exception('Failed to load apps');
    }
  }

  Future<void> createApp(App app) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/apps'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(app.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create app');
    }
  }
}

class App {
  int id;
  String name;
  String description;

  App({required this.id, required this.name, required this.description});

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
