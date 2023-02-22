import 'package:flutter/material.dart';

class TransactionChartBar extends StatelessWidget {
  final String weekdayLabel;
  final double amountSpent;
  final double? spendingPercentage;

  const TransactionChartBar({
    Key? key,
    required this.weekdayLabel,
    required this.amountSpent,
    this.spendingPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (_, constraints){
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${amountSpent.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.03),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.03),
          SizedBox(
            height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(weekdayLabel)),
          ),
        ],
      );
    });
  }
}
