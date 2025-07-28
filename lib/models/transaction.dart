class TransactionModel {
  final String id;
  final String receiver;
  final String method;
  final String status;
  final double amount;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.receiver,
    required this.method,
    required this.status,
    required this.amount,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['_id'],
      receiver: json['receiver'],
      method: json['method'],
      status: json['status'],
      amount: double.tryParse(json['amount'].toString()) ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
