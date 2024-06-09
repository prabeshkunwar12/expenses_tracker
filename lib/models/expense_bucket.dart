import 'package:expense_tracker/models/expense.dart';

class ExpenseBucket {
  final Category category;
  final List<Expense> expenseList;

  ExpenseBucket({required this.category, required this.expenseList});

  //filter in all the expenses that belong to the given category
  ExpenseBucket.forCategory(
      {required this.category, required List<Expense> allExpenses})
      : expenseList = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenseList) {
      sum += expense.amount;
    }
    return sum;
  }
}
