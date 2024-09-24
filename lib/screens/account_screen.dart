import 'package:flutter/material.dart';
import 'account_detail_screen.dart'; // Import màn hình chi tiết tài khoản

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản của bạn'),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('../../img/imgcat.jpg'), // Avatar
              ),
              SizedBox(height: 20),
              Text(
                'Phan Minh Duc',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text('phanminhduc@gmail.com'), // Email người dùng
              SizedBox(height: 20),

              // Danh sách tùy chọn tài khoản
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Chi tiết tài khoản'),
                      onTap: () {
                        // Điều hướng đến màn hình chi tiết tài khoản
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AccountDetailScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.lock),
                      title: Text('Đổi mật khẩu'),
                      onTap: () {
                        // Thêm hành động đổi mật khẩu
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.brightness_6),
                      title: Text('Chế độ Dark Mode'),
                      trailing: Switch(
                        value: false,
                        onChanged: (bool value) {
                          // Thêm hành động bật/tắt chế độ Dark Mode
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Đăng xuất'),
                      onTap: () {
                        // Thêm hành động đăng xuất
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
