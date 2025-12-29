import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}



class _Expenses extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Education',
      date: DateTime.now(),
      amount: 25.00,
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      date: DateTime(2025, 12, 27),
      amount: 10.00,
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(context: context , builder: (ctx){
      return const NewExpense();
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter expense tracker'),
        actions: [IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [
          Text("the chart"),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
