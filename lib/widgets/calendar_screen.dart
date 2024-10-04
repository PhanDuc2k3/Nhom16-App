import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<Map<String, dynamic>> _transactions = []; // Lưu trữ danh sách giao dịch
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAllTransactions(); // Lấy tất cả giao dịch khi khởi động ứng dụng
  }

  // Lấy tất cả giao dịch từ Firestore theo userId và sau đó lọc theo ngày trong Dart
  Future<void> _fetchAllTransactions() async {
    setState(() {
      _isLoading = true; // Hiển thị biểu tượng xoay trong khi tải
    });

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        // Lấy tất cả giao dịch cho userId hiện tại
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('transactions')
            .where('userId', isEqualTo: userId) // Chỉ lọc theo userId
            .get();

        // Lưu trữ tất cả giao dịch vào một danh sách
        List<Map<String, dynamic>> transactions = snapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return {
            'id': doc.id,
            'title': data['title'],
            'amount': data['amount'] is int ? (data['amount'] as int).toDouble() : data['amount'],
            'date': (data['date'] as Timestamp).toDate(),
            'userId': data['userId'],
          };
        }).toList();

        setState(() {
          _transactions = transactions; // Gán dữ liệu giao dịch
          _isLoading = false; // Ngừng hiển thị biểu tượng xoay
        });
      }
    } catch (error) {
      print('Error fetching transactions: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Lọc giao dịch cho ngày được chọn
  List<Map<String, dynamic>> _getTransactionsForSelectedDay() {
    return _transactions.where((transaction) {
      final DateTime transactionDate = transaction['date'];
      return transactionDate.year == _selectedDay.year &&
             transactionDate.month == _selectedDay.month &&
             transactionDate.day == _selectedDay.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = _getTransactionsForSelectedDay(); // Lọc giao dịch cho ngày được chọn

    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay; // Cập nhật ngày được chọn
                _focusedDay = focusedDay; // Cập nhật ngày được focus
              });
            },
          ),
          SizedBox(height: 16),
          _isLoading
              ? Center(child: CircularProgressIndicator()) // Hiển thị biểu tượng xoay khi tải
              : filteredTransactions.isEmpty
                  ? Center(child: Text('Không có giao dịch nào cho ngày này'))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredTransactions.length,
                        itemBuilder: (ctx, index) {
                          final transaction = filteredTransactions[index];
                          return ListTile(
                            title: Text(transaction['title']),
                            subtitle: Text(
                                '${transaction['date'].day}/${transaction['date'].month}/${transaction['date'].year}'),
                            trailing: Text(
                                '\$${transaction['amount'].toStringAsFixed(2)}'),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
