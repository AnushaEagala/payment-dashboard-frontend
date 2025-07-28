class Payment {
  final String id;
  final double amount;
  final String status;
  final String createdAt;

  Payment({
    required this.id,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['_id'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      createdAt: json['createdAt'],
    );
  }
}
