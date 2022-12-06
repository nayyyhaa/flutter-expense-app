import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction) {
    print('1 NewTransaction Contructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('2. NewTransaction createState');
    return NewTransactionState();
  }
}

class NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var selectedDate;
  String errorMsg = '';

  NewTransactionState() {
    print('3. NewTransactionState Contructor');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('4. initState');
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('5. didUpdateWidget');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('6. dispose');
  }

  void submitNewTransaction() {
    final userTitle = titleController.text;
    var userAmount;
    try {
      userAmount = double.parse(amountController.text);
    } catch (e) {
      userAmount = 0;
    }
    if (userTitle.isEmpty || userAmount <= 0 || selectedDate == null) {
      setState(() {
        errorMsg = "Enter valid data!!";
      });
      return;
    }
    widget.addNewTransaction(userTitle, userAmount, selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitNewTransaction,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitNewTransaction,
              ),
              Container(
                height: 70,
                child: Row(children: [
                  Expanded(
                      child: Text(
                    selectedDate == null
                        ? 'No date choosen!'
                        : 'Selected Date: ${DateFormat.yMd().format(selectedDate)}',
                  )),
                  TextButton(
                    onPressed: presentDatePicker,
                    child: Text(
                      'Select date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorDark,
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  errorMsg,
                  style: TextStyle(color: Color.fromARGB(255, 233, 77, 66)),
                ),
              ),
              ElevatedButton(
                onPressed: submitNewTransaction,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColorDark,
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
