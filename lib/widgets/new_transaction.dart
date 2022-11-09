import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                addNewTransaction(
                    titleController.text, double.parse(amountController.text));
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 115, 41, 167),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
