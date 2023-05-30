import 'package:flutter/material.dart';
import 'package:untitled1/login.dart';
import 'package:untitled1/nav.dart';
import 'package:untitled1/signup.dart';

void main() {
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}
