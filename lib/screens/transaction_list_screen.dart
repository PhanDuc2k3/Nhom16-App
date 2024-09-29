import 'package:flutter/material.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/transaction_item.dart';
import 'account_screen.dart'; // Nhớ import màn hình tài khoản
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;
// class TransactionListScreen extends StatefulWidget {
//   @override
//   _TransactionListScreenState createState() => _TransactionListScreenState();
// }

// class _TransactionListScreenState extends State<TransactionListScreen> {
//   final List<Transaction> _transactions = [];
//   int _selectedIndex = 0;

//   void _addTransaction(String title, double amount) {
//     final newTransaction = Transaction(
//       id: DateTime.now().toString(),
//       title: title,
//       amount: amount,
//       date: DateTime.now(),
//     );

//     setState(() {
//       _transactions.add(newTransaction);
//     });
//   }

//   void _openAddTransactionScreen() {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (ctx) => AddTransactionScreen(_addTransaction),
//       ),
//     );
//   }

//   void _onItemTapped(int index) {
//     if (index == 2) {
//       _openAddTransactionScreen();
//     } else if (index == 4) { // Nếu chọn mục tài khoản
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (ctx) => AccountScreen(), // Chuyển đến màn hình tài khoản
//         ),
//       );
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   double get _totalAmount {
//     return _transactions.fold(0.0, (sum, item) => sum + item.amount);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quản lý Chi tiêu'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Tổng số tiền: \$${_totalAmount.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _transactions.length,
//               itemBuilder: (ctx, index) {
//                 return TransactionItem(transaction: _transactions[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Trang chủ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Lịch',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_circle, size: 40),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.analytics),
//             label: 'Biểu đồ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Tài khoản',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         showUnselectedLabels: true,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Thêm dòng này
// import 'add_transaction_screen.dart';
// import '../models/transaction.dart';
// class TransactionListScreen extends StatefulWidget {
//   @override
//   _TransactionListScreenState createState() => _TransactionListScreenState();
// }

// class _TransactionListScreenState extends State<TransactionListScreen> {
//   final List<Map<String, dynamic>> _transactions = []; // Danh sách giao dịch
//   final FirebaseAuth _auth = FirebaseAuth.instance; // Khởi tạo FirebaseAuth
//   User? user; // Khai báo biến user

//   @override
//   void initState() {
//     super.initState();
//     user = _auth.currentUser; // Lấy thông tin người dùng hiện tại
//   }

//   void addTransaction(String title, double amount) {
//     if (user == null) return; // Kiểm tra nếu user không tồn tại

//     // Thêm giao dịch vào Firestore
//     FirebaseFirestore.instance.collection('transactions').add({
//       'title': title,
//       'amount': amount,
//       'userId': user!.uid, // Lưu userId
//       'date': Timestamp.now(), // Lưu ngày giờ
//     }).then((value) {
//       setState(() {
//         _transactions.add({
//           'id': value.id,
//           'title': title,
//           'amount': amount,
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Giao dịch của bạn'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _transactions.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_transactions[index]['title']),
//                   subtitle: Text(_transactions[index]['amount'].toString()),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => AddTransactionScreen(addTransaction), // Truyền hàm
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
      
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'add_transaction_screen.dart'; // Nhập file thêm giao dịch của bạn

// class TransactionListScreen extends StatefulWidget {
//   @override
//   _TransactionListScreenState createState() => _TransactionListScreenState();
// }

// class _TransactionListScreenState extends State<TransactionListScreen> {
//   int _selectedIndex = 0; // Biến để theo dõi tab đang chọn

//   List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(), // Trang chủ
//     CalendarScreen(), // Màn hình lịch
//     AddTransactionScreen(addTransaction), // Màn hình thêm giao dịch
//     ChartScreen(), // Màn hình biểu đồ
//     AccountScreen(), // Màn hình tài khoản
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Cập nhật tab đã chọn
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Danh sách giao dịch'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex), // Hiển thị widget dựa trên tab đã chọn
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Trang chủ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Lịch',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_circle, size: 40),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.analytics),
//             label: 'Biểu đồ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Tài khoản',
//           ),
//         ],
//         currentIndex: _selectedIndex, // Đánh dấu tab hiện tại
//         onTap: _onItemTapped, // Gọi hàm khi tab được chọn
//       ),
//     );
//   }
// }

// // Ví dụ về các widget cho các màn hình
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Trang chủ'));
//   }
// }

// class CalendarScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Lịch'));
//   }
// }

// class ChartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Biểu đồ'));
//   }
// }

// class AccountScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Tài khoản'));
//   }
// }




// class TransactionListScreen extends StatefulWidget {
//   @override
//   _TransactionListScreenState createState() => _TransactionListScreenState();
// }

// class _TransactionListScreenState extends State<TransactionListScreen> {
//   final List<Transaction> _transactions = [];
//   int _selectedIndex = 0; // Trạng thái chỉ số được chọn

//   void addTransaction(String title, double amount) {
//   final userId = FirebaseAuth.instance.currentUser?.uid; // Lấy userId từ Firebase Auth

//   // Kiểm tra nếu userId không null
//   if (userId == null) {
//     // Xử lý khi không có userId (có thể là báo lỗi hoặc return)
//     return; // Hoặc hiển thị thông báo cho người dùng
//   }

//   final newTransaction = Transaction(
//     id: DateTime.now().toString(),
//     title: title,
//     amount: amount,
//     date: DateTime.now(),
//     userId: userId, // Thêm userId vào đây
//   );

//   setState(() {
//     _transactions.add(newTransaction);
//   });
// }

//   // Danh sách các Widget cho các màn hình
//   List<Widget> _widgetOptions = <Widget>[
//     // Thay thế bằng màn hình chính của bạn
//     Center(child: Text('Trang chủ')), // Ví dụ
//     CalendarScreen(), // Màn hình lịch
//     // Thêm giao dịch
//     Center(child: Text('Thêm giao dịch')), // Chúng ta sẽ hiển thị AddTransactionScreen trong BottomNavigationBar
//     ChartScreen(), // Màn hình biểu đồ
//     ProfileScreen(), // Màn hình tài khoản
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quản lý Chi tiêu'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               // Hiển thị AddTransactionScreen khi nhấn nút
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return AddTransactionScreen(addTransaction); // Truyền hàm ở đây
//                 },
//               );
//             },
//           )
//         ],
//       ),
//       body: _widgetOptions[_selectedIndex], // Hiển thị màn hình tương ứng với chỉ số được chọn
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Trang chủ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Lịch',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_circle, size: 40),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.analytics),
//             label: 'Biểu đồ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Tài khoản',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/transaction_item.dart';
import 'account_screen.dart'; // Nhớ import màn hình tài khoản
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;
import '../models/transaction.dart';
import '../widgets/calendar_screen.dart';
import '../widgets/chart_screen.dart';
import '../widgets/profile_screen.dart';

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final List<Transaction> _transactions = [];
  int _selectedIndex = 0; // Trạng thái chỉ số được chọn

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      Firestore.FirebaseFirestore.instance
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
        setState(() {
          _transactions.clear();
          _transactions.addAll(snapshot.docs.map((doc) {
            return Transaction(
              id: doc.id,
              title: doc['title'],
              amount: doc['amount'],
              date: (doc['date'] as Firestore.Timestamp).toDate(),
              userId: doc['userId'],
            );
          }));
        });
      });
    }
  }

  double get _totalAmount {
    return _transactions.fold(0.0, (sum, item) => sum + item.amount);
  }

  void addTransaction(String title, double amount) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return; // Xử lý khi không có userId
    }

    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      userId: userId,
    );

    // Lưu giao dịch vào Firestore
    Firestore.FirebaseFirestore.instance.collection('transactions').add({
      'title': title,
      'amount': amount,
      'date': Firestore.Timestamp.now(),
      'userId': userId,
    });

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Tổng số tiền: \$${_totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              return TransactionItem(transaction: _transactions[index]);
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _widgetOptions() {
    return <Widget>[
      _buildHomeScreen(),
      CalendarScreen(),
      ChartScreen(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý Chi tiêu'),
      ),
      body: _widgetOptions()[_selectedIndex], // Hiển thị màn hình tương ứng
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddTransactionScreen(addTransaction);
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Cân đối khoảng cách
          children: <Widget>[
            _buildBottomNavigationItem(Icons.home, 'Trang chủ', 0),
            _buildBottomNavigationItem(Icons.calendar_today, 'Lịch', 1),
            SizedBox(width: 36), // Khoảng cách giữa nút thêm giao dịch và các nút khác
            _buildBottomNavigationItem(Icons.analytics, 'Biểu đồ', 2),
            _buildBottomNavigationItem(Icons.account_circle, 'Tài khoản', 3),
          ],
        ),
      ),
    );
  }

  // Tạo từng nút cho BottomAppBar
  Widget _buildBottomNavigationItem(IconData icon, String label, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blue : Colors.grey, // Màu sắc dựa trên chỉ số hiện tại
      ),
      onPressed: () {
        _onItemTapped(index); // Thay đổi chỉ số khi nhấn vào nút
      },
      tooltip: label, // Nhãn cho nút
    );
  }
}
