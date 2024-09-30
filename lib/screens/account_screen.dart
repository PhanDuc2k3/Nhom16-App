import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/account_detail_screen.dart';
import 'package:flutter_application_1/Login/auth_gate.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Khởi tạo FirebaseAuth
  String email = 'Đang tải...'; // Giá trị mặc định cho email khi chưa có dữ liệu

  @override
  void initState() {
    super.initState();
    _fetchEmail(); // Gọi hàm để lấy email khi khởi tạo màn hình
  }

  // Hàm lấy email từ FirebaseAuth
  void _fetchEmail() {
    User? user = _auth.currentUser; // Lấy người dùng hiện tại
    if (user != null) {
      setState(() {
        email = user.email ?? 'Không có email'; // Gán email nếu có
      });
    } else {
      setState(() {
        email = 'Không có email'; // Nếu không có người dùng
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
                backgroundImage: AssetImage('assets/img/imgcat.jpg'), // Đường dẫn đến ảnh avatar
              ),
              SizedBox(height: 20),
              Text(
                'Phan Minh Duc', // Tên người dùng
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(email), // Hiển thị email
              SizedBox(height: 20),

              // Danh sách tùy chọn tài khoản
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Chỉnh sửa tài khoản'),
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
                onTap: () async {
                  // Hiển thị dialog xác nhận đăng xuất
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Xác nhận đăng xuất'),
                        content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Đóng dialog
                            },
                            child: Text('Hủy'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await _auth.signOut(); // Đăng xuất
                              // Chuyển đến màn hình đăng nhập
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => AuthGate()),
                                (Route<dynamic> route) => false, // Xóa tất cả các màn hình trước đó
                              );
                            },
                            child: Text('Đăng xuất'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
