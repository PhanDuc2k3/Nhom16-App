import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function(String) onDelete;
  final Function(Transaction) onEdit;

  TransactionItem({
    required this.transaction,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transaction.title),
      subtitle: Text('\$${transaction.amount.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              onEdit(transaction); // Gọi hàm sửa
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(transaction.id); // Gọi hàm xóa
            },
          ),
        ],
      ),
    );
  }
}
