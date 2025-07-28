import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddPaymentScreen extends StatefulWidget {
  @override
  _AddPaymentScreenState createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String receiver = '';
  String method = 'card';
  String status = 'success';
  double amount = 0.0;

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await ApiService.addPayment({
        'receiver': receiver,
        'method': method,
        'status': status,
        'amount': amount,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simulate Payment")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(labelText: "Receiver"), onSaved: (v) => receiver = v!),
              TextFormField(decoration: InputDecoration(labelText: "Amount"), keyboardType: TextInputType.number, onSaved: (v) => amount = double.parse(v!)),
              DropdownButtonFormField(
                value: method,
                onChanged: (v) => setState(() => method = v!),
                items: ['card', 'paypal'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              ),
              DropdownButtonFormField(
                value: status,
                onChanged: (v) => setState(() => status = v!),
                items: ['success', 'failed', 'pending'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: submit, child: Text("Add Payment")),
            ],
          ),
        ),
      ),
    );
  }
}
