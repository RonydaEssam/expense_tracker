import "package:flutter/material.dart";
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 650,
      category: Category.work,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Port Said Trip',
      amount: 350,
      category: Category.travel,
      date: DateTime(2025, 10, 11),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        backgroundColor: Color.fromRGBO(176, 206, 136, 100),
      ),
      body: Column(
        children: [
          Text('Chart will be here ...'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
