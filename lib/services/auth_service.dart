// lib/services/auth_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'http://localhost:3000'; // Replace if your backend runs elsewhere

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: { 'Content-Type': 'application/json' },
      body: json.encode({ 'email': email, 'password': password }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['access_token'];
      // Save token securely here if needed
      print('Login successful. Token: $token');
      return true;
    } else {
      print('Login failed. Status code: ${response.statusCode}');
      return false;
    }
  }
}
