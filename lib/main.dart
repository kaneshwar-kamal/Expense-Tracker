import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';


var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 95, 218, 255),
);


void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 198, 242, 255),
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kColorScheme.secondaryContainer,
          margin:EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,

          )
        ),
        textTheme: TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 23,
          )
        ),
      ),
      home: Expenses(
        onAddExpense: (expense) {},
      ),
    ),
  );
}