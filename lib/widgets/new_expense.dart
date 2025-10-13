import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: ListView(
        children: [
          const TextField(
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              label: Text('Amount'),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          DropdownMenu(
            width: double.infinity,
            label: Text('Category'),
            dropdownMenuEntries: [],
          ),
          DatePickerDialog(
            firstDate: DateTime(2020),
            lastDate: DateTime(2028),
          ),
        ],
      ),
    );
  }
}
