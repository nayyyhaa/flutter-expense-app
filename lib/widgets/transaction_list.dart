import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transactions made yet!",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          child: Flexible(
                            fit: FlexFit.tight,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                                  style: TextStyle(
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('EEE, M/d/y')
                              .format(transactions[index].date),
                        )));
              },
              itemCount: transactions.length,
            ),
    );
  }
}
