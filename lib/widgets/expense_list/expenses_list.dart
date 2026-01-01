import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        // REPAIR: Use the unique ID string as the key instead of the whole object
        key: ValueKey(expenses[index].id), 
        
        // OPTIONAL BUT RECOMMENDED: Add a background color so it looks like a deletion
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}