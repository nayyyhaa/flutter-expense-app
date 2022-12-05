import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTransaction,
  });

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  '\$${transaction.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Flexible(
          fit: FlexFit.tight,
          child: Text(
            transaction.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        subtitle: Text(
          DateFormat('EEE, M/d/y').format(transaction.date),
        ),
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            MediaQuery.of(context).size.width > 460
                ? TextButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('edit aint working'),
                    onPressed: () => {})
                : IconButton(
                    icon: Icon(Icons.edit),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => {},
                  ), // icon-1
            IconButton(
              icon: Icon(Icons.delete),
              color: Color.fromARGB(255, 233, 93, 93),
              onPressed: () => deleteTransaction(transaction.id),
            ), // icon-2
          ],
        ),
      ),
    );
  }
}
