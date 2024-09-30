import 'package:flutter/material.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/transaction_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;
import '../models/transaction.dart';
import '../widgets/calendar_screen.dart';
import '../widgets/chart_screen.dart';
import './account_screen.dart'; // Nhập khẩu cho màn hình tài khoản

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final List<Transaction> _transactions = [];
  int _selectedIndex = 0; // Trạng thái chỉ số được chọn

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      Firestore.FirebaseFirestore.instance
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
        setState(() {
          _transactions.clear();
          _transactions.addAll(snapshot.docs.map((doc) {
            return Transaction(
              id: doc.id,
              title: doc['title'],
              amount: doc['amount'],
              date: (doc['date'] as Firestore.Timestamp).toDate(),
              userId: doc['userId'],
            );
          }));
        }); 
      });
    }
  }

  double get _totalAmount {
    return _transactions.fold(0.0, (sum, item) => sum + item.amount);
  }

  void addTransaction(String title, double amount) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return; // Xử lý khi không có userId
    }

    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      userId: userId,
    );

    // Lưu giao dịch vào Firestore
    Firestore.FirebaseFirestore.instance.collection('transactions').add({
      'title': title,
      'amount': amount,
      'date': Firestore.Timestamp.now(),
      'userId': userId,
    });

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    Firestore.FirebaseFirestore.instance
        .collection('transactions')
        .doc(id)
        .delete(); // Xóa giao dịch từ Firestore

    setState(() {
      _transactions.removeWhere((tx) => tx.id == id); // Cập nhật danh sách
    });
  }

  void _editTransaction(Transaction transaction) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddTransactionScreen(
          (title, amount) {
            Firestore.FirebaseFirestore.instance
                .collection('transactions')
                .doc(transaction.id)
                .update({
              'title': title,
              'amount': amount,
              'date': Firestore.Timestamp.now(),
            });

            setState(() {
              // Cập nhật danh sách với giá trị mới
              final index = _transactions.indexWhere((tx) => tx.id == transaction.id);
              if (index >= 0) {
                _transactions[index] = Transaction(
                  id: transaction.id,
                  title: title,
                  amount: amount,
                  date: DateTime.now(),
                  userId: transaction.userId,
                );
              }
            });
          },
          existingTransaction: transaction, // Truyền giao dịch hiện tại
        );
      },
    );
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Tổng số tiền: \$${_totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              return TransactionItem(
                transaction: _transactions[index],
                onDelete: _deleteTransaction, // Truyền hàm xóa
                onEdit: _editTransaction, // Truyền hàm sửa
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _widgetOptions() {
    return <Widget>[
      _buildHomeScreen(),
      CalendarScreen(),
      ChartScreen(),
      AccountScreen(), // Giữ lại AccountScreen ở đây
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý Chi tiêu'),
      ),
      body: _widgetOptions()[_selectedIndex], // Hiển thị màn hình tương ứng
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddTransactionScreen(addTransaction);
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Cân đối khoảng cách
          children: <Widget>[
            _buildBottomNavigationItem(Icons.home, 'Trang chủ', 0),
            _buildBottomNavigationItem(Icons.calendar_today, 'Lịch', 1),
            SizedBox(width: 36), // Khoảng cách giữa nút thêm giao dịch và các nút khác
            _buildBottomNavigationItem(Icons.analytics, 'Biểu đồ', 2),
            _buildBottomNavigationItem(Icons.account_circle, 'Tài khoản', 3),
          ],
        ),
      ),
    );
  }

  // Tạo từng nút cho BottomAppBar
  Widget _buildBottomNavigationItem(IconData icon, String label, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blue : Colors.grey, // Màu sắc dựa trên chỉ số hiện tại
      ),
      onPressed: () {
        _onItemTapped(index); // Thay đổi chỉ số khi nhấn vào nút
      },
      tooltip: label, // Nhãn cho nút
    );
  }
}
