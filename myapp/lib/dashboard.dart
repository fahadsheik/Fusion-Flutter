import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final String name;
  final String designation;

  const DashboardPage({super.key, required this.name, required this.designation});

  @override
  Widget build(BuildContext context) {
    final blueColor = const Color(0xFF0A88E2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text('Gymkhana Dashboard', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome!', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Role: $designation'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
