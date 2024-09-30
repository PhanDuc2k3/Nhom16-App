import 'package:flutter/material.dart';
import '../models/transaction.dart';

class EditTransactionScreen extends StatefulWidget {
  final Transaction transaction;
  final Function updateTransaction;

  EditTransactionScreen({
    required this.transaction,
    required this.updateTransaction,
  });

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.transaction.title);
    _amountController = TextEditingController(text: widget.transaction.amount.toString());
  }

  void _submitData() {
    final updatedTitle = _titleController.text;
    final updatedAmount = double.tryParse(_amountController.text) ?? 0;

    if (updatedTitle.isEmpty || updatedAmount <= 0) {
      return; // Có thể thêm thông báo lỗi ở đây
    }

    widget.updateTransaction(widget.transaction.id, updatedTitle, updatedAmount);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa Giao dịch'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _submitData, // Nút này sẽ cập nhật thông tin
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Số tiền'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20), // Khoảng cách giữa các widget
            ElevatedButton(
              onPressed: _submitData, // Nút để cập nhật thông tin
              child: Text('Cập nhật giao dịch'),
            ),
          ],
        ),
      ),
    );
  }
}
