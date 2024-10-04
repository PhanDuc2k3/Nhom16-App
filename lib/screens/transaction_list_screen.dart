import 'package:flutter/material.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/transaction_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;
import '../models/transaction.dart';
import '../widgets/calendar_screen.dart';
import '../widgets/chart_screen.dart';
import './account_screen.dart';

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final List<Transaction> _transactions = [];
  bool _isLoading = true; // Trạng thái tải dữ liệu
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        Firestore.FirebaseFirestore.instance
            .collection('transactions')
            .where('userId', isEqualTo: userId)
            .snapshots()
            .listen((snapshot) {
          List<Transaction> fetchedTransactions = snapshot.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;

            // Chuyển đổi từ int sang double nếu cần
            double amount = data['amount'] is int
                ? (data['amount'] as int).toDouble()
                : data['amount'];

            return Transaction(
              id: doc.id,
              title: data['title'] ?? '', // Đảm bảo không có null
              amount: amount, // Chuyển kiểu nếu cần
              date: (data['date'] as Firestore.Timestamp).toDate(),
              userId: data['userId'] ?? '',
            );
          }).toList();

          setState(() {
            _transactions.clear();
            _transactions.addAll(fetchedTransactions);
            _isLoading = false; // Dừng xoay tròn sau khi tải xong
          });
        });
      }
    } catch (error) {
      print('Error fetching transactions: $error');
      setState(() {
        _isLoading = false; // Dừng xoay tròn nếu có lỗi
      });
    }
  }

  double get _totalAmount {
    return _transactions.fold(0.0, (sum, item) => sum + item.amount);
  }

  void addTransaction(String title, double amount) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      userId: userId,
    );

    try {
      await Firestore.FirebaseFirestore.instance.collection('transactions').add({
        'title': title,
        'amount': amount,
        'date': Firestore.Timestamp.now(),
        'userId': userId,
      });

      setState(() {
        _transactions.add(newTransaction);
      });
    } catch (error) {
      print('Error adding transaction: $error');
    }
  }

  void _deleteTransaction(String id) async {
    try {
      await Firestore.FirebaseFirestore.instance.collection('transactions').doc(id).delete();

      setState(() {
        _transactions.removeWhere((tx) => tx.id == id);
      });
    } catch (error) {
      print('Error deleting transaction: $error');
    }
  }

  void _editTransaction(Transaction transaction) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddTransactionScreen(
          (title, amount) async {
            try {
              await Firestore.FirebaseFirestore.instance
                  .collection('transactions')
                  .doc(transaction.id)
                  .update({
                'title': title,
                'amount': amount,
                'date': Firestore.Timestamp.now(),
              });

              setState(() {
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
            } catch (error) {
              print('Error updating transaction: $error');
            }
          },
          existingTransaction: transaction,
        );
      },
    );
  }

  Widget _buildHomeScreen() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Biểu tượng tải khi chưa có dữ liệu
      );
    }

    if (_transactions.isEmpty) {
      return Center(
        child: Text(
          'Không có giao dịch nào',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

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
                onDelete: _deleteTransaction,
                onEdit: _editTransaction,
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
      AccountScreen(),
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
      body: _widgetOptions()[_selectedIndex],
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildBottomNavigationItem(Icons.home, 'Trang chủ', 0),
            _buildBottomNavigationItem(Icons.calendar_today, 'Lịch', 1),
            SizedBox(width: 36),
            _buildBottomNavigationItem(Icons.analytics, 'Biểu đồ', 2),
            _buildBottomNavigationItem(Icons.account_circle, 'Tài khoản', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, String label, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blue : Colors.grey,
      ),
      onPressed: () => _onItemTapped(index),
      tooltip: label,
    );
  }
}
