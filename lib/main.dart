import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_expense_app/widgets/chart.dart';

import './models/Transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  //to keep app in portarit mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
    Transaction(
      id: 't3',
      title: 'Purse',
      amount: 95,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Blanket',
      amount: 105,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Band',
      amount: 15,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Bottle',
      amount: 95,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Dry Fruits',
      amount: 115,
      date: DateTime.now(),
    ),
  ];

  var _isChartVisible = false;

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

  List<Widget> _buildLandscapeMode(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.05,
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Show Chart',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Switch.adaptive(
                activeColor: Theme.of(context).primaryColorLight,
                value: _isChartVisible,
                onChanged: (val) {
                  setState(() {
                    _isChartVisible = val;
                  });
                })
          ],
        ),
      ),
      _isChartVisible
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txList
    ];
  }

  List<Widget> _buildPortraitMode(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscapeMode = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => openModalTransaction(context),
                )
              ],
            ))
        : AppBar(
            title: const Text("Xpense App"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => openModalTransaction(context),
              )
            ],
          );
    final txList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.65,
        child: TransactionList(_userTransactions, deleteTransaction));
    final appBody = SafeArea(
        child: Column(
      children: <Widget>[
        if (_isLandscapeMode)
          ..._buildLandscapeMode(mediaQuery, appBar, txList),
        if (!_isLandscapeMode)
          ..._buildPortraitMode(mediaQuery, appBar, txList),
      ],
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: appBody,
          )
        : Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => openModalTransaction(context),
                    child: const Icon(Icons.add),
                    elevation: 12,
                    hoverElevation: 30,
                  ),
          );
  }
}
