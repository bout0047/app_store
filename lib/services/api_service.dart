import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_store/models/app_model.dart';

class ApiService {
  static const String baseUrl = 'http://10.5.1.121:5106/api'; // For Android emulator, use localhost for desktop

  Future<List<AppModel>> fetchApps() async {
    final response = await http.get(Uri.parse('$baseUrl/apps'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((app) => AppModel.fromJson(app)).toList();
    } else {
      throw Exception('Failed to load apps');
    }
  }

  // Fetch popular apps (Optional)
  Future<List<AppModel>> fetchPopularApps() async {
    final response = await http.get(Uri.parse('$baseUrl/popularApps'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((app) => AppModel.fromJson(app)).toList();
    } else {
      throw Exception('Failed to load popular apps');
    }
  }
}
