import 'package:flutter/material.dart';
import 'package:flutter_expense_app/widgets/chart.dart';
import './models/Transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      home: const MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Quicksand'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
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

  void addNewTransaction(String titleTx, double amountTx, selectedDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: titleTx,
        amount: amountTx,
        date: selectedDate);

    setState(() => {_userTransactions.add(newTransaction)});
  }

  void deleteTransaction(String id) {
    setState(() => {_userTransactions.removeWhere((txn) => txn.id == id)});
  }

  void openModalTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((txn) =>
            txn.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xpense App"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => openModalTransaction(context),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(_userTransactions, deleteTransaction),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openModalTransaction(context),
        child: const Icon(Icons.add),
        elevation: 12,
        hoverElevation: 30,
      ),
    );
  }
}
