import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submit() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    // validate
    if (title.isEmpty || value <= 0) return;
    // submit
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(labelText: 'Título'),
            controller: titleController,
            onSubmitted: (_) => _submit(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Valor (R\$)'),
            controller: valueController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submit(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _submit,
                child: Text('Nova despesa'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
