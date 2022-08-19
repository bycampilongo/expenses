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
      id: 't9',
      title: 'Remédios',
      value: 80.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't10',
      title: 'Remédios',
      value: 80.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't11',
      title: 'Remédios',
      value: 80.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't12',
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

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    // close the modal
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  _openTransFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransFormModal(context),
        )
      ],
    );
    final avaibleHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: avaibleHeight * 0.2,
              child: Chart(_recentTransactions),
            ),
            SizedBox(
              height: avaibleHeight * 0.7,
              child: TransactionList(
                transactions: _transactions,
                onRemove: _removeTransaction,
              ),
            ),
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
