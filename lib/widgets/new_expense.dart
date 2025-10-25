import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  var _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);
    final lastDate = DateTime(now.year + 2, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final titleIsInvalid = _titleController.text.trim().isEmpty;
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final dateIsInvalid = _selectedDate == null;

    String errorMessage = '';

    if (titleIsInvalid) {
      errorMessage = 'Please enter a valid title.';
    } else if (amountIsInvalid) {
      errorMessage = 'Please enter a valid amount.';
    } else if (dateIsInvalid) {
      errorMessage = 'Please enter a valid date.';
    }

    if (errorMessage.isNotEmpty) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Invalid input',
              textAlign: TextAlign.center,
            ),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
      return;
    }
    // saving and creating the new expense
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount!,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(20, 48, 20, keyboardSpace + 20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      suffixText: ' EGP',
                      label: Text('Amount'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'not selected'
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.date_range),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text(
                    'Save Expense',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
