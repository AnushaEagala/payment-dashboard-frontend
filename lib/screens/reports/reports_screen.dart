import 'package:flutter/material.dart';
import '../services/report_service.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportService _reportService = ReportService();
  Map<String, dynamic>? _reports;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    try {
      final data = await _reportService.fetchReports();
      setState(() {
        _reports = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildReportView() {
    if (_reports == null) return const Text('No data available');

    // Example: Showing revenue trends and failed transactions count
    final revenueTrend = _reports!['revenueTrend'] ?? [];
    final failedCount = _reports!['failedTransactionsCount'] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Failed Transactions: $failedCount', style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        const Text('Revenue Trends:', style: TextStyle(fontSize: 18)),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: revenueTrend.length,
            itemBuilder: (context, index) {
              final item = revenueTrend[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    '\$${item['amount']}\n${item['month']}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('Error: $_error'))
                : _buildReportView(),
      ),
    );
  }
}
