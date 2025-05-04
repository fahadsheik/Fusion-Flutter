import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mess_dashboard.dart';

class ViewMenuScreen extends StatefulWidget {
  const ViewMenuScreen({super.key});

  @override
  State<ViewMenuScreen> createState() => _ViewMenuScreenState();
}

class _ViewMenuScreenState extends State<ViewMenuScreen> {
  int _activeTabIndex = 0;

  final List<String> _tabs = ['Mess 1', 'Mess 2'];

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabContents = [
      Image.asset(
          'assets/mess_menu.png',
        width: MediaQuery.of(context).size.width
      ),
      Image.asset(
          'assets/mess_menu.png',
          width: MediaQuery.of(context).size.width
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MessDashboard(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_tabs.length, (index) {
                final bool isSelected = _activeTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _activeTabIndex = index;
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      _tabs[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                child: tabContents[_activeTabIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
