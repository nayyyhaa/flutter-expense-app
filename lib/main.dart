import 'package:flutter/material.dart';
import './widgets/user_transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Xpense App"),
          backgroundColor: Color.fromARGB(255, 126, 86, 226),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: const Card(
                child: Text("CHART!"),
              ),
            ),
            UserTransactions()
          ],
        ),
      ),
    );
  }
}
