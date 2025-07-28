import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/payment.dart';

static Future<List<Payment>> getPayments() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/payments'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $yourToken', // Replace with your token
    },
  );
  final List data = jsonDecode(response.body);
  return data.map((item) => Payment.fromJson(item)).toList();
}
