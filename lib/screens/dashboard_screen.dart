// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int totalToday = 0;
  int totalWeek = 0;
  double revenue = 0;
  int failed = 0;
  List<FlSpot> revenueData = [];

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  void fetchStats() async {
    final stats = await ApiService.getPaymentStats();
    setState(() {
      totalToday = stats['totalToday'];
      totalWeek = stats['totalWeek'];
      revenue = stats['revenue'];
      failed = stats['failed'];
      revenueData = List.generate(stats['revenueTrends'].length, (i) {
        return FlSpot(i.toDouble(), stats['revenueTrends'][i].toDouble());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            InfoCard(title: 'Today\'s Transactions', value: totalToday.toString()),
            InfoCard(title: 'This Week', value: totalWeek.toString()),
            InfoCard(title: 'Revenue (€)', value: revenue.toStringAsFixed(2)),
            InfoCard(title: 'Failed Transactions', value: failed.toString()),
            SizedBox(height: 16),
            Text("Revenue Trend", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: LineChart(LineChartData(
                titlesData: FlTitlesData(show: false),
                lineBarsData: [LineChartBarData(spots: revenueData)],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title, value;

  InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(title: Text(title), trailing: Text(value)),
    );
  }
}
