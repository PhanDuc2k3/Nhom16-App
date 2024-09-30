import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  final Function addTransaction;

  AddTransactionScreen(this.addTransaction);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  bool isAddingMoney = true; // Mặc định là thêm tiền

  void submitData() {
    final title = titleController.text;
    final amount = double.tryParse(amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) {
      return;
    }

    // Gọi hàm thêm giao dịch với số tiền âm nếu giảm tiền
    widget.addTransaction(title, isAddingMoney ? amount : -amount);
    Navigator.of(context).pop(); // Đóng màn hình sau khi thêm giao dịch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Giao dịch'),
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
                      backgroundColor: isAddingMoney ? Colors.green : Colors.grey[300],
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
                      backgroundColor: !isAddingMoney ? Colors.red : Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Hiển thị nội dung cho thêm tiền
            if (isAddingMoney) ...[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Số tiền'),
                keyboardType: TextInputType.number,
              ),
            ] else ...[
              // Hiển thị nội dung cho giảm tiền (nếu cần)
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Số tiền'),
                keyboardType: TextInputType.number,
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitData,
              child: Text('Thêm Giao dịch'),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../models/transaction.dart';
// class AddTransactionScreen extends StatefulWidget {
//   final Function addTransaction; // Nhận hàm addTransaction

//   AddTransactionScreen(this.addTransaction); // Constructor yêu cầu 1 tham số

//   @override
//   _AddTransactionScreenState createState() => _AddTransactionScreenState();
// }

// class _AddTransactionScreenState extends State<AddTransactionScreen> {
//   final titleController = TextEditingController();
//   final amountController = TextEditingController();
//   bool isAddingMoney = true;
//   final user = FirebaseAuth.instance.currentUser;

//   void submitData() async {
//     final title = titleController.text;
//     final amount = double.tryParse(amountController.text) ?? 0;

//     if (title.isEmpty || amount <= 0) {
//       return;
//     }

//     widget.addTransaction(title, isAddingMoney ? amount : -amount);

//     // Lưu vào Firestore
//     await FirebaseFirestore.instance.collection('transactions').add({
//       'title': title,
//       'amount': isAddingMoney ? amount : -amount,
//       'userId': user?.uid,
//       'date': Timestamp.now(),
//     });

//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thêm Giao dịch'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isAddingMoney = true;
//                       });
//                     },
//                     child: Text('Thêm tiền'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isAddingMoney ? Colors.green : Colors.grey[300],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isAddingMoney = false;
//                       });
//                     },
//                     child: Text('Giảm tiền'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: !isAddingMoney ? Colors.red : Colors.grey[300],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(labelText: 'Tiêu đề'),
//             ),
//             TextField(
//               controller: amountController,
//               decoration: InputDecoration(labelText: 'Số tiền'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: submitData,
//               child: Text('Thêm Giao dịch'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
