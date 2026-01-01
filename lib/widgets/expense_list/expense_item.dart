import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget{

  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Column(
          children: [
            Text(expense.title, style:TextStyle(
              fontSize: 15,

            ) ,),
            //style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(), //spacer widget will take all the remaining space to display the output
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width:10),
                    Text(expense.formattedDate)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}