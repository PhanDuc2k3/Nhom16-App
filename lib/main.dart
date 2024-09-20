import 'package:flutter/material.dart';
import 'screens/transaction_list_screen.dart';

void main() {
  runApp(SpendingManagerApp());
}

class SpendingManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Chi tiêu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TransactionListScreen(),
    );
  }
}
