import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  final void Function(Expense expense) onRemove;

  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expensesList[index]),
        onDismissed: (direction) {
          onRemove(expensesList[index]);
        },
        child: ExpenseItem(
          expense: expensesList[index],
        ),
      ),
    );
  }
}
