import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Dummy expense 1',
        amount: 20.00,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Dummy expense 2',
        amount: 20.00,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Dummy expense 3',
        amount: 20.00,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child: ExpensesList(expensesList: _registeredExpenses)),
        ],
      ),
    );
  }
}
