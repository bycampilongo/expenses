import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:flutter/material.dart';

import '../components/transaction_form.dart';
import '../components/transaction_list.dart';
import '../models/transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Conta Antiga',
      value: 400.00,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 200.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't7',
      title: 'Gasolina',
      value: 100.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Compras',
      value: 100.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Remédios',
      value: 80.00,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) => element.date.isAfter(DateTime.now().subtract(
              const Duration(days: 7),
            )))
        .toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    // close the modal
    Navigator.of(context).pop();
  }

  _openTransFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransFormModal(context),
      ),
    );
  }
}
