import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/select.dart';
import 'package:untitled1/screen/Auth/Login/login.dart';

void main() {
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eo_Neo',
      home: ChangeNotifierProvider(
        create: (_) => SelectProvider(),
        child: const Login(),
      ),
    );
  }
}
