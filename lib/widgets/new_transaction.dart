import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  void submitNewTransaction() {
    final userTitle = titleController.text;
    final userAmount = double.parse(amountController.text);

    if (userTitle.isEmpty || userAmount <= 0) return;
    addNewTransaction(userTitle, userAmount);
  }

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
              onSubmitted: (_) => submitNewTransaction,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitNewTransaction,
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: submitNewTransaction,
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
