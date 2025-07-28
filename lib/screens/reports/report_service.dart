import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  static const String baseUrl = 'http://localhost:3000'; // Adjust your backend URL

  Future<Map<String, dynamic>> fetchReports() async {
    final response = await http.get(Uri.parse('$baseUrl/reports'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load reports');
    }
  }
}
