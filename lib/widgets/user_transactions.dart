import 'package:flutter/material.dart';

import '../models/Transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 70.6,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Dress',
      amount: 75,
      date: DateTime.now(),
    ),
  ];

  void addNewTransaction(titleTx, amountTx) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: titleTx,
        amount: amountTx,
        date: DateTime.now());

    setState(() => {_userTransactions.add(newTransaction)});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
