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

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quản lý chi tiêu',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Chào mừng trở lại!',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'hãy đăng nhập  !',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 32),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Mật Khẩu',
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.visibility_off),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       // Handle forgot password
//                     },
//                     child: Text('Quên Mật Khẩu?'),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle login
//                   },
//                   child: Text('Đăng Nhập'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 50),
//                     foregroundColor: Colors.red,
//                   ),
//                 ),
//                 SizedBox(height: 32),
//                 Row(
//                   children: [
//                     Expanded(child: Divider()),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       // child: Text('Hoặc tiếp tục với'),
//                     ),
//                     Expanded(child: Divider()),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     ElevatedButton.icon(
//                 //       onPressed: () {
//                 //         // Handle Google login
//                 //       },
//                 //       icon: Image.asset('assets/google_icon.png', height: 24),
//                 //       label: Text('Google'),
//                 //       style: ElevatedButton.styleFrom(
//                 //         foregroundColor: Colors.white,
//                 //         // foregroundColor: Colors.black,
//                 //         minimumSize: Size(140, 50),
//                 //       ),
//                 //     ),
//                 //     SizedBox(width: 16),
//                 //     ElevatedButton.icon(
//                 //       onPressed: () {
//                 //         // Handle Facebook login
//                 //       },
//                 //       icon: Icon(Icons.facebook),
//                 //       label: Text('Facebook'),
//                 //       style: ElevatedButton.styleFrom(
//                 //         backgroundColor: Colors.blue,
//                 //         minimumSize: Size(140, 50),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 // SizedBox(height: 32),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Không có tài khoản?'),
//                     TextButton(
//                       onPressed: () {
//                         // Handle sign up
//                       },
//                       child: Text('Đăng ký ngay'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
