import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http; // Import gói http
import 'dart:convert'; // Để xử lý JSON
import '../screens/account_detail_screen.dart'; // Import màn hình chi tiết tài khoản
import 'package:flutter_application_1/Login/auth_gate.dart';
import 'package:flutter_application_1/widgets/profile_screen.dart'; // Đảm bảo đường dẫn đúng

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
    _fetchEmail(); // Gọi API để lấy email khi khởi tạo màn hình
  }

  // Hàm gọi API để lấy email
  Future<void> _fetchEmail() async {
    try {
      // Ví dụ URL API, bạn thay bằng URL của server bạn
      final response = await http.get(Uri.parse('https://api.example.com/user-email'));

      if (response.statusCode == 200) {
        // Parse JSON để lấy email từ API
        final data = json.decode(response.body);
        setState(() {
          email = data['email'] ?? 'Không có email';
        });
      } else {
        setState(() {
          email = 'Lỗi khi lấy email';
        });
      }
    } catch (e) {
      setState(() {
        email = 'Lỗi kết nối';
      });
    }
  }

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
                backgroundImage: AssetImage('assets/img/imgcat.jpg'), // Đường dẫn đến ảnh avatar
              ),
              SizedBox(height: 20),
              Text(
                'Phan Minh Duc', // Tên người dùng
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(email), // Hiển thị email sau khi lấy từ API
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
