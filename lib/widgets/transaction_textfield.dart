import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTextfield extends StatefulWidget {
  final Function addTx;
  TransactionTextfield({
    Key? key,
    required this.addTx,
  }) : super(key: key);

  @override
  State<TransactionTextfield> createState() => _TransactionTextfieldState();
}

class _TransactionTextfieldState extends State<TransactionTextfield> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _chosenDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _chosenDate == null)
      return;
    widget.addTx(enteredTitle, enteredAmount, _chosenDate);
    Navigator.of(context).pop();
  }

  void _displayDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _chosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              //SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _chosenDate == null
                          ? 'No date selected: '
                          : 'Chosen date: ${DateFormat('dd-MM-yyyy').format(_chosenDate as DateTime)}',
                    ),
                  ),
                  //SizedBox(width: 5),
                  TextButton(
                    onPressed: _displayDate,
                    child: const Text('Select a date'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
