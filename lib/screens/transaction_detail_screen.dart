import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${transaction.id}'),
            Text('Receiver: ${transaction.receiver}'),
            Text('Method: ${transaction.method}'),
            Text('Status: ${transaction.status}'),
            Text('Amount: \$${transaction.amount}'),
            Text('Created At: ${transaction.createdAt.toLocal()}'),
          ],
        ),
      ),
    );
  }
}
