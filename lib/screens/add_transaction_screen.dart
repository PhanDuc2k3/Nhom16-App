import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart' as localTransaction;

class AddTransactionScreen extends StatefulWidget {
  final Function addTransaction;
  final localTransaction.Transaction? existingTransaction; // Giao dịch hiện tại (có thể là null nếu là thêm mới)

  AddTransactionScreen(this.addTransaction, {this.existingTransaction});

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  bool isAddingMoney = true; // Mặc định là thêm tiền

  @override
  void initState() {
    super.initState();

    // Nếu là chỉnh sửa giao dịch, điền sẵn thông tin vào các trường
    if (widget.existingTransaction != null) {
      titleController.text = widget.existingTransaction!.title;
      amountController.text = widget.existingTransaction!.amount.toString();
      isAddingMoney = widget.existingTransaction!.amount > 0;
    }
  }

  void submitData() async {
  final title = titleController.text;
  final amount = double.tryParse(amountController.text) ?? 0;

  if (title.isEmpty || amount == 0) {
    return;
  }

  if (widget.existingTransaction == null) {
    // Thêm mới giao dịch vào Firestore
    await firestore.FirebaseFirestore.instance.collection('transactions').add({
      'title': title,
      'amount': isAddingMoney ? amount : -amount,
      'date': firestore.Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser?.uid,
    });
  } else {
    // Sửa giao dịch hiện tại trên Firestore
    await firestore.FirebaseFirestore.instance
        .collection('transactions')
        .doc(widget.existingTransaction!.id)
        .update({
      'title': title,
      'amount': isAddingMoney ? amount : -amount,
      'date': firestore.Timestamp.now(),
    });
  }

  Navigator.of(context).pop(); // Đóng màn hình sau khi thêm hoặc sửa giao dịch
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingTransaction == null
            ? 'Thêm Giao dịch'
            : 'Chỉnh sửa Giao dịch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hiển thị hai nút trong một hàng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isAddingMoney = true; // Chọn thêm tiền
                      });
                    },
                    child: Text('Thêm tiền'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isAddingMoney ? Colors.green : Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(width: 10), // Khoảng cách giữa hai nút
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isAddingMoney = false; // Chọn giảm tiền
                      });
                    },
                    child: Text('Giảm tiền'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !isAddingMoney ? Colors.red : Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Hiển thị nội dung cho thêm tiền
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Số tiền'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitData,
              child: Text(widget.existingTransaction == null
                  ? 'Thêm Giao dịch'
                  : 'Cập nhật Giao dịch'),
            ),
          ],
        ),
      ),
    );
  }
}
