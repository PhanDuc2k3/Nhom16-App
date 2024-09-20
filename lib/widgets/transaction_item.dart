import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(transaction.title),
        subtitle: Text(transaction.date.toString()),
        trailing: Text('\$${transaction.amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
