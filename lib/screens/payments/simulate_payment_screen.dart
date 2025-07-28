import 'package:flutter/material.dart';
import '../services/payment_service.dart';

class PaymentSimulationScreen extends StatefulWidget {
  @override
  _PaymentSimulationScreenState createState() =>
      _PaymentSimulationScreenState();
}

class _PaymentSimulationScreenState extends State<PaymentSimulationScreen> {
  final PaymentService _paymentService = PaymentService();
  final _formKey = GlobalKey<FormState>();

  String _amount = '';
  String _description = '';
  bool _isProcessing = false;
  String? _resultMessage;

  void _simulatePayment() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isProcessing = true;
      _resultMessage = null;
    });

    try {
      final result =
          await _paymentService.simulatePayment(double.parse(_amount), _description);
      setState(() {
        _resultMessage = 'Payment simulation successful: $result';
      });
    } catch (e) {
      setState(() {
        _resultMessage = 'Payment simulation failed: $e';
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Simulation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter an amount';
                      }
                      if (double.tryParse(val) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (val) => _amount = val!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    onSaved: (val) => _description = val ?? '',
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isProcessing ? null : _simulatePayment,
                    child: _isProcessing
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))
                        : Text('Simulate Payment'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (_resultMessage != null)
              Text(
                _resultMessage!,
                style: TextStyle(
                  color: _resultMessage!.toLowerCase().contains('successful')
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
