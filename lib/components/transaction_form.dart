import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submit() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    // validate
    if (title.isEmpty || value < 0) return;
    // submit
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _selectedDate = (value as DateTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Título'),
            controller: _titleController,
            onSubmitted: (_) => _submit(),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Valor (R\$)'),
            controller: _valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submit(),
          ),
          SizedBox(
            height: 90,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Data da despesa: ${DateFormat('d/M/y').format(_selectedDate)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text(
                    'Selecionar a data',
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(
              bottom: 20,
            ),
            width: MediaQuery.of(context).size.width * 1,
            height: 60,
            child: ElevatedButton(
              onPressed: _submit,
              child: Text(
                'Nova despesa',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
