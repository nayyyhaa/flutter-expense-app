import 'package:flutter/material.dart';
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
      home: MyHomePage(),
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

  void addNewTransaction(String titleTx, double amountTx) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: titleTx,
        amount: amountTx,
        date: DateTime.now());

    setState(() => {_userTransactions.add(newTransaction)});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xpense App"),
        backgroundColor: Color.fromARGB(255, 126, 86, 226),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => openModalTransaction(context),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: const Card(
              child: Text("CHART!"),
            ),
          ),
          Column(
            children: [
              NewTransaction(addNewTransaction),
              TransactionList(_userTransactions),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openModalTransaction(context),
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 126, 86, 226),
        elevation: 12,
        hoverElevation: 30,
      ),
    );
  }
}
