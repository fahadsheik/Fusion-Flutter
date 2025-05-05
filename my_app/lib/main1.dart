import 'package:flutter/material.dart';
import 'rules.dart'; // Make sure this file exists in your project

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor\'s Hostel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RulesGuidelinesPage(),
    );
  }
}
