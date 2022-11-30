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
    return LayoutBuilder(builder: (BuildContext ctx, constraint) {
      return Column(
        children: <Widget>[
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${sprendingAmt.toStringAsFixed(0)}'),
              )),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.6,
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
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            child: FittedBox(child: Text(label)),
            height: constraint.maxHeight * 0.15,
          )
        ],
      );
    });
  }
}
