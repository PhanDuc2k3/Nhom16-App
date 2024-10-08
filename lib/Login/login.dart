import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Login/auth_gate.dart';
import 'package:flutter_application_1/screens/transaction_list_screen.dart';
import 'package:flutter_application_1/Login/login.dart'; // Nhập LoginScreen

class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
     home:  LoginScreen(),
   );
 }
}


// class MyApp extends StatelessWidget {
//  const MyApp({super.key});
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: const AuthGate(),
//    );
//  }
// }