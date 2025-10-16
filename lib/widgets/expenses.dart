import 'package:expense_tracker/widgets/new_expense.dart';
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(249, 245, 240, 100),
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        backgroundColor: Color.fromRGBO(244, 153, 26, 100),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Placeholder(
            fallbackHeight: 180,
          ),
          SizedBox(height: 8),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
