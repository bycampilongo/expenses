import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      recentTransaction.reduce((value, element) => null)

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': 9.99,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [],
      ),
    );
  }
}
