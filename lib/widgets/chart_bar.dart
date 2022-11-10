import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final sprendingAmt;
  final label;
  final spendingPtg;

  ChartBar(
      {super.key,
      required this.sprendingAmt,
      required this.label,
      required this.spendingPtg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          child: Text('\$${sprendingAmt.toStringAsFixed(0)}'),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(2)),
            ),
            FractionallySizedBox(
              heightFactor: spendingPtg,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(2)),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        Text(label)
      ],
    );
  }
}
