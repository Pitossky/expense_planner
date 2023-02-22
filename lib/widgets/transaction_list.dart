import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> txList;
  final Function deleteTx;
  const TransactionList(
      {Key? key, required this.txList, required this.deleteTx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);

    return txList.isEmpty
        ? Center(
            child: Text(
              'No Transaction added yet!',
              style: textTheme.textTheme.titleMedium,
            ),
          )
        : ListView.builder(
            itemCount: txList.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          '\$${txList[index].amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    txList[index].title,
                    style: textTheme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat('dd-MM-yyyy').format(txList[index].date),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          onPressed: () => deleteTx(txList[index].id),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : IconButton(
                          onPressed: () => deleteTx(txList[index].id),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                ),
              );
            },
          );
  }
}
