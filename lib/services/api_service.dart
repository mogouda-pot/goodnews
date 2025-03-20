// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = 'cc38e4e5375e47438762dfd693a0a9a2';

  Future<Map<String, dynamic>> getTopHeadlines(
     {String country = 'us'}) async {
    try {
      print('Making API request for top headlines');
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=$country&apiKey=$apiKey'),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception(
          'Failed to load data: ${response.statusCode}\nBody: ${response.body}',
        );
      }
    } catch (e) {
      print('API Service Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTopHeadlines4Category(
    String category, {
    String country = 'us',
  }) async {
    try {
      print('Making API request for category: $category');
      final response = await http.get(
        Uri.parse(
          '$baseUrl/top-headlines?country=$country&category=$category&apiKey=$apiKey',
        ),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception(
          'Failed to load data: ${response.statusCode}\nBody: ${response.body}',
        );
      }
    } catch (e) {
      print('API Service Error: $e');
      rethrow;
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
