import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(PaymentDashboardApp());
}

class PaymentDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: LoginScreen(),
    );
  }
}
