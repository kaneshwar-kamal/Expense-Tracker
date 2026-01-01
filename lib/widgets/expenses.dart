import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key,required this.onAddExpense});

  final void Function (Expense expense) onAddExpense;

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
    showModalBottomSheet(
      isScrollControlled: true, //it will take the full screne 
      context: context , 
      builder: (ctx){
      return NewExpense(onAddExpense: _addExpense);
    });
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration : Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: 'undo',
          onPressed: (){
            setState(() {
            _registeredExpenses.insert(expenseIndex,expense);
            });
          },
        )
    ));
  }


  @override
  Widget build(context) {

    Widget mainContent =const Center(
      child: Text("No expenses found. Start adding some !"),);

    if(_registeredExpenses.isNotEmpty){
      mainContent =  ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter expense tracker'),
        actions: [IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [
          Text("the chart"),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
