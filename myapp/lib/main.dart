import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard.dart';

void main() {
  runApp(const GymkhanaApp());
}

class GymkhanaApp extends StatelessWidget {
  const GymkhanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gymkhana App',
      theme: ThemeData(
        primaryColor: const Color(0xFF0A88E2), // Blue from logo
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
