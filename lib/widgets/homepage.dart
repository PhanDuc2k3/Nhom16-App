import 'package:flutter/material.dart';
import '../models/transaction.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang Chủ'),
      ),
      body: Center(
        child: Text('Nội dung Trang Chủ'),
      ),
    );
  }
}
