import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // These below lines will take extra memory space
  // var _enteredTile = '';
  // void _saveTitleInput(String inputValue){
  //   _enteredTile = inputValue;
  // }

  //So to avoid extra memeory storage we use TextEditingController()
  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  DateTime? _selectedDateTime;

  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();

    // Create a date for the very beginning of the allowed range (e.g., 100 years ago)
    final firstDate = DateTime(now.year - 100, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now, // The date the picker shows first (Today)
      firstDate: firstDate, // Now the user can scroll back 100 years
      lastDate: now, // The user cannot select future dates (if you want that)
    ); // .then((value){}, this method will acccept the selected output in the future
    setState(() {
      _selectedDateTime = pickedDate;
    });
  }

  void _submitExpenseData(){
    final _enterdAmount = double.tryParse(_costController.text); //trypsae will convert to string if not null
    final amountIsValid = _enterdAmount == null || _enterdAmount < 0 ;
    
    if(_titleController.text.trim().isEmpty || amountIsValid || _selectedDateTime == null){
        showDialog(
          context: context,
          builder: (ctx)=> AlertDialog(
          title: Text("Invalid Input"),
          content: Text("Please make sure to add valid data :) "),
          actions: [
            TextButton(
              onPressed: (){
              Navigator.pop(ctx);
            }, child: Text("Close")),
          ],
        ));
      return;
    }
    widget.onAddExpense(Expense(
      title: _titleController.text,
      amount: _enterdAmount, 
      date: _selectedDateTime!, 
      category: _selectedCategory));
    Navigator.pop(context);
  }


  @override
  void dispose() {
    _titleController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        children: [
          TextField(
            controller:
                _titleController, // this is responsible for the text field
            //onChanged: _saveTitleInput, We dont need this, coz we use controller
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _costController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Cost"),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDateTime == null
                          ? "NO date selected"
                          : formatter.format(_selectedDateTime!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  });
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  //print(_titleController.text);
                  //print(_costController.text);
                  _submitExpenseData();
                  //Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
