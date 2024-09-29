import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String id; // ID của giao dịch
  final String title; // Tiêu đề giao dịch
  final double amount; // Số tiền
  final DateTime date; // Ngày giao dịch
  final String userId; // ID của người dùng

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.userId,
  });

  // Hàm để tạo đối tượng Transaction từ Firestore Document
  factory Transaction.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Transaction(
      id: documentId,
      title: data['title'] ?? '', // Trả về chuỗi rỗng nếu không có tiêu đề
      amount: data['amount'] ?? 0.0, // Trả về 0 nếu không có số tiền
      date: (data['date'] as Timestamp).toDate(), // Chuyển đổi từ Timestamp sang DateTime
      userId: data['userId'] ?? '', // Trả về chuỗi rỗng nếu không có userId
    );
  }
}
