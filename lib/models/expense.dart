import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_tracker/tools.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }

  IconData? get icon {
    return categoryIcons.containsKey(category)
        ? categoryIcons[category]
        : Icons.money;
  }
}
