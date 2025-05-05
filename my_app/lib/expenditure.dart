import 'package:flutter/material.dart';
import 'menu.dart'; // ✅ Import SidebarMenu

class ExpenditurePage extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      'name': 'Sindhu\n22BCS233',
      'date': '22 Feb 2025',
      'amount': '₹1820',
      'status': 'pending'
    },
    {
      'name': 'Rishitha\n22BCS216',
      'date': '05 Oct 2024',
      'amount': '₹2800',
      'status': 'paid'
    },
    {
      'name': 'Varshith\n22BCS176',
      'date': '20 Dec 2023',
      'amount': '₹1000',
      'status': 'paid'
    },
    {
      'name': 'Abhi\n22BCS001',
      'date': '11 Apr 2023',
      'amount': '₹2050',
      'status': 'paid'
    },
    {
      'name': 'Sindhu\n22BCS233',
      'date': '21 Jan 2023',
      'amount': '₹3200',
      'status': 'paid'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Profile & Menu Row
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage('assets/images/sindu_vakkurthy.png'),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Sindhu Vukkurthy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[800],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SidebarMenu(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('MENU'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Title & Buttons
              const Text(
                "Visitor’s Hostel",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("Manage Bookings"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                    label: const Text("Expenditure"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Balance
              const Text(
                "Current Balance : ₹2500",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),

              const SizedBox(height: 20),

              // Table Box
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Table(
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: Colors.grey.shade300),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(2.5),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(1.5),
                  },
                  children: [
                    // Table Header
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      children: [
                        _headerCell('Name & ID'),
                        _headerCell('Booking Date'),
                        _headerCell('Bill Amount'),
                        _headerCell('Status'),
                      ],
                    ),
                    // Data Rows
                    for (var row in data)
                      TableRow(
                        decoration: BoxDecoration(
                          color: row['status'] == 'paid'
                              ? Colors.green[50]
                              : Colors.white,
                        ),
                        children: [
                          _tableCell(row['name']!),
                          _tableCell(row['date']!),
                          _tableCell(row['amount']!),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: row['status'] == 'paid'
                                    ? Colors.green[100]
                                    : Colors.red[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                row['status'] == 'paid'
                                    ? '✓ Paid'
                                    : '⨯ Pending',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: row['status'] == 'paid'
                                      ? Colors.green[800]
                                      : Colors.red[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text),
    );
  }
}
