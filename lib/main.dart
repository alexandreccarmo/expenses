import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';


main()=>runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
      return MaterialApp(
        home: MyHomePage(),
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final List<Transaction> _transactions = [
    Transaction(id: 't0', title: 'Conta antiga', value: 400.76, date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(id: 't1', title: 'Novo Tênis de corrida', value: 310.76, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: 't2', title: 'Conta de luz', value: 211.30, date: DateTime.now().subtract(Duration(days: 34))),
    Transaction(id: 't3', title: 'Conta de agua', value: 250.30, date: DateTime.now().subtract(Duration(days: 34))),
    Transaction(id: 't4', title: 'Conta de internet', value: 390.80, date: DateTime.now().subtract(Duration(days: 34))),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr){
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value){
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now()
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context, 
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('Despesas pessoais'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_transactions),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }

}