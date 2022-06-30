import 'dart:math';

import 'package:flutter/material.dart';

import '../components/transaction_form.dart';
import '../components/transaction_list.dart';
import '../models/transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 200.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Cartão de crédito',
      value: 300.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de Celular',
      value: 56.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Conta de Internet',
      value: 75.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Jantar',
      value: 50.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Barbeiro',
      value: 25.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Gasolina',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Compras',
      value: 40.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Remédios',
      value: 80.00,
      date: DateTime.now(),
    ),
  ];

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
            Container(
              padding: EdgeInsets.all(10),
              color: Theme.of(context).primaryColor,
              child: Card(
                child: Text(
                  'grafico',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
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
