import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (BuildContext ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transactions made yet!",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
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
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
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
                      transactions[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('EEE, M/d/y').format(transactions[index].date),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Theme.of(context).primaryColor,
                        onPressed: () => {},
                      ), // icon-1
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Color.fromARGB(255, 233, 93, 93),
                        onPressed: () =>
                            deleteTransaction(transactions[index].id),
                      ), // icon-2
                    ],
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
