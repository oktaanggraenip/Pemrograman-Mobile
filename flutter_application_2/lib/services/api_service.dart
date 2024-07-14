import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'https://flutter-quiz-766a5-default-rtdb.asia-southeast1.firebasedatabase.app';

  // Fetch data
  static Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('$_baseUrl/users.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data.values.toList(); // Menyusun ulang data menjadi list
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Create data
  static Future<bool> createData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users.json'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200; // Firebase biasanya mengembalikan 200 untuk operasi sukses
  }

  // Update data
  static Future<bool> updateData(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/users/$id.json'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;
  }

  // Delete data
  static Future<bool> deleteData(String id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/users/$id.json'),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;
  }
}
