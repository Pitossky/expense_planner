import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/widgets/tx_chart_bar.dart';

class TransactionChart extends StatelessWidget {
  final List<Transaction> recentTx;
  const TransactionChart({
    Key? key,
    required this.recentTx,
  }) : super(key: key);

  List<Map<String, Object>> get groupedTxValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTx.length; i++) {
        if (recentTx[i].date.day == weekDay.day &&
            recentTx[i].date.month == weekDay.month &&
            recentTx[i].date.year == weekDay.year) {
          totalSum += recentTx[i].amount;
        }
      }
      //print('week day: ${DateFormat.E().format(weekDay).substring(0, 2)}');
      //print('total sum: $totalSum');

      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 2),
        'Amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTxValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['Amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxValues.map((groupedTx) {
            return Flexible(
              fit: FlexFit.tight,
              child: TransactionChartBar(
                weekdayLabel: groupedTx['Day'] as String,
                amountSpent: groupedTx['Amount'] as double,
                spendingPercentage: maxSpending == 0.0 ? 0.0 : (groupedTx['Amount'] as double)/maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
