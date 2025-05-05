import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';
  bool isLoading = false;

  Future<void> login() async {
    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse('http://localhost:8000/api/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      final userResponse = await http.get(
        Uri.parse('http://localhost:8000/api/auth/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (userResponse.statusCode == 200) {
        final userData = jsonDecode(userResponse.body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(
              name: userData['name'],
              designation: userData['designation_info'][0],
            ),
          ),
        );
      } else {
        setState(() => errorMessage = 'Failed to fetch user data');
      }
    } else {
      setState(() => errorMessage = 'Invalid credentials');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final blueColor = const Color(0xFF0A88E2); // IIITDMJ blue

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/iiitdmj_logo.png', height: 100),
              const SizedBox(height: 32),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueColor,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
