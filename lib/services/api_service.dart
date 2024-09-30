// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_store/models/app_model.dart';
import 'package:app_store/models/category_model.dart';
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_store/models/app_model.dart';
import 'package:app_store/models/category_model.dart';

class ApiService {
  final String baseUrl = 'http://localhost:5106/api'; // Update with your backend URL

  Future<List<AppModel>> fetchApps() async {
    final response = await http.get(Uri.parse('$baseUrl/apps'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((app) => AppModel.fromJson(app)).toList();
    } else {
      throw Exception('Failed to load apps');
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((category) => CategoryModel.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
