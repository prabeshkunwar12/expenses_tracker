import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/tools.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _showDialog() {
    Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text(
                  'Please make sure a calid title, amount, date and category was entered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
          )
        : showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text(
                  'Please make sure a calid title, amount, date and category was entered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
          );
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsinvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsinvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    Expense expense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.onAddExpense(expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _openDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    Widget titleField = TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Title')),
    );

    Widget amountField = TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$',
        label: Text('Amount'),
      ),
    );

    Widget datePicker = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_selectedDate == null
            ? 'No Date Selected'
            : dateFormatter.format(_selectedDate!)),
        IconButton(
          onPressed: _openDatePicker,
          icon: const Icon(
            Icons.calendar_month,
          ),
        ),
      ],
    );

    Widget submitButton = ElevatedButton(
      onPressed: _submitExpenseData,
      child: const Text('Submit'),
    );
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Cancel'),
    );

    Widget categorySelector = DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category.name.toString().toUpperCase()),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          if (value == null) return;
          _selectedCategory = value;
        });
      },
    );

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                width < 600
                    ? titleField
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: titleField,
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: amountField,
                          ),
                        ],
                      ),
                width < 600
                    ? Row(
                        children: [
                          Expanded(
                            child: amountField,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: datePicker,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          categorySelector,
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: datePicker,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 16,
                ),
                width < 600
                    ? Row(
                        children: [
                          categorySelector,
                          const Spacer(),
                          submitButton,
                          cancelButton,
                        ],
                      )
                    : Row(
                        children: [
                          const Spacer(),
                          submitButton,
                          cancelButton,
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
