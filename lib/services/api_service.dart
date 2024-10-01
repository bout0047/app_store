import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/app_model.dart';

class ApiService {
  final String baseUrl = 'http://localhost:5106/api';

  Future<List<AppModel>> fetchApps() async {
    final response = await http.get(Uri.parse('$baseUrl/apps'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => AppModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load apps');
    }
  }
}
