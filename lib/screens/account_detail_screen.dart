import 'package:flutter/material.dart';

class AccountDetailScreen extends StatelessWidget {
  // Giả sử bạn có thông tin người dùng
  final String name = 'Phan Minh Duc';
  final String dob = '01/01/2005'; // Ngày sinh
  final String email = 'phanminhduc@gmail.com';
  final String address = '123 Đường ABC, Thành phố XYZ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết tài khoản'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Họ và tên:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(name, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              'Ngày sinh:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(dob, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              'Email:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(email, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              'Địa chỉ:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(address, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
