import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Thêm dòng này
import 'firebase_options.dart'; // Thêm dòng này để sử dụng DefaultFirebaseOptions
import 'screens/transaction_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login/login.dart';
import 'Login/auth_gate.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo khung Flutter khởi tạo xong
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Khởi tạo Firebase
  );
  
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
      home:  AuthGate(),
    );
  }
}
class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Nếu chưa đăng nhập, chuyển đến trang đăng nhập
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Hiển thị khi đang tải
        } else if (!snapshot.hasData) {
          return  MyApp() ; // Trang đăng nhập nếu chưa có người dùng
        }
        // Nếu đã đăng nhập, chuyển đến trang chủ
        return TransactionListScreen(); // Trang chủ
      },
    );
  }
}