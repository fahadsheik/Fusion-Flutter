import 'package:flutter/material.dart';
import '../../../utils/bottom_bar.dart';

class VerifyBonafidePage extends StatelessWidget {
  const VerifyBonafidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top AppBar Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.png'),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'AKSHAY PAREWA',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                    ),
                    onPressed: () {},
                    child: const Text('MENU',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.blue),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Academic Assistant Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'AKSHAY PAREWA\nCSE STUDENT',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Table and Legend
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade400),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.5),
                        3: FlexColumnWidth(1.5),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("S.No.", textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("3", textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("2", textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("1", textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                        _buildTableRow("Student Name", ["", "", ""]),
                        _buildTableRow("Roll No", ["", "❌", "✅"]),
                        _buildTableRow("Type", ["", "", ""]),
                        _buildTableRow("Approve/ Deny", ["❌", "", ""]),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Status Legend
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _LegendItem(icon: "✅", label: "Approved"),
                          _LegendItem(icon: "⏳", label: "Pending"),
                          _LegendItem(icon: "❌", label: "Declined"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Table row builder
  static TableRow _buildTableRow(String label, List<String> values) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, textAlign: TextAlign.center),
        ),
        for (var val in values)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(val, textAlign: TextAlign.center),
          ),
      ],
    );
  }
}

// Legend item widget
class _LegendItem extends StatelessWidget {
  final String icon;
  final String label;

  const _LegendItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
