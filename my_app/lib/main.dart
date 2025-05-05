import 'package:flutter/material.dart';
import 'menu.dart';  // Import the SidebarMenu
import 'rules.dart'; // Import the RulesGuidelinesPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor Hostel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // Set initial route to the home page
      routes: {
        '/': (context) => RulesGuidelinesPage(), // Start with RulesGuidelinesPage
        '/menu': (context) => SidebarMenu(), // Route to SidebarMenu (Menu page)
      },
    );
  }
}
