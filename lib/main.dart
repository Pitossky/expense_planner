import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/widgets/transaction_chart.dart';
import 'package:personal_expense_tracker/widgets/transaction_list.dart';
import 'package:personal_expense_tracker/widgets/transaction_textfield.dart';
import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                      titleLarge: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))
                  .headline6)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _txList = [
    // Transaction(
    //   id: '1',
    //   title: 'New bag',
    //   date: DateTime.now(),
    //   amount: 75.02,
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'New watch',
    //   date: DateTime.now(),
    //   amount: 95.02,
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTx {
    return _txList.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTx(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _txList.add(newTx);
    });
  }

  void _displayBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionTextfield(addTx: _addNewTx);
      },
    );
  }

  void _deleteTx(String id) {
    setState(() {
      _txList.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('recent tx: $_recentTx');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('EXPENSE PLANNER'),
    );

    final txListSizedBox = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        txList: _txList,
        deleteTx: _deleteTx,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Switch chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              _txList.isNotEmpty
                  ? SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.3,
                      child: TransactionChart(recentTx: _recentTx),
                    )
                  : Container(),
            if (!isLandscape) txListSizedBox,
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: TransactionChart(recentTx: _recentTx),
                    )
                  : txListSizedBox,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _displayBottomSheet();
        },
      ),
    );
  }
}
