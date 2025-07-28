import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/payment.dart';
import 'transaction_detail_screen.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Payment> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchPayments();
  }

  void fetchPayments() async {
    final data = await ApiService.getPayments();
    setState(() {
      transactions = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Transactions')),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return ListTile(
            title: Text("Amount: €${tx.amount.toStringAsFixed(2)}"),
            subtitle: Text("Status: ${tx.status}"),
            trailing: Text(tx.createdAt.split('T')[0]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TransactionDetailScreen(transaction: tx),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
