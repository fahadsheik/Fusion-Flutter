import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mess_dashboard.dart';

class ViewBillAndPaymentsScreen extends StatefulWidget {
  const ViewBillAndPaymentsScreen({super.key});

  @override
  State<ViewBillAndPaymentsScreen> createState() => _ViewBillAndPaymentsScreenState();
}

class _ViewBillAndPaymentsScreenState extends State<ViewBillAndPaymentsScreen> {
  int _activeTabIndex = 0;

  final List<String> _tabs = ['View Bill', 'Payment History'];

  Widget viewBills() {
    final List<Map<String, String>> tableData = [
      {
        'Month': 'February',
        'Monthly Base Amount': '1200',
        'Rebate Amount': '200',
        'Monthly Bill': '1000',
      },
      {
        'Month': 'February',
        'Monthly Base Amount': '1200',
        'Rebate Amount': '200',
        'Monthly Bill': '1000',
      },
      {
        'Month': 'February',
        'Monthly Base Amount': '1200',
        'Rebate Amount': '200',
        'Monthly Bill': '1000',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: Color(0xFF989898), width: 1),
            columnWidths: const {
              0: FixedColumnWidth(80.0),
              1: FixedColumnWidth(120.0),
              2: FixedColumnWidth(100.0),
              3: FixedColumnWidth(100.0),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFFF0F0F1)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Month',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Monthly Base Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Rebate Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Monthly Bill',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              ...tableData.map((row) {
                return TableRow(
                  decoration: const BoxDecoration(color: Colors.white),
                  children: row.entries.map((entry) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          entry.value,
                          textAlign: TextAlign.center,
                        ),
                      );
                  }).toList(),
                );
              }).toList(),
            ],
          ),

        ],
      ),
    );
  }

  Widget paymentHistory() {
    final List<Map<String, String>> tableData = [
      {
        'Payment Date': 'February',
        'Amount': '1200',
        'Month': 'April',
        'Year': '2025',
      },
      {
        'Payment Date': 'February',
        'Amount': '1200',
        'Month': 'April',
        'Year': '2025',
      },
      {
        'Payment Date': 'February',
        'Amount': '1200',
        'Month': 'April',
        'Year': '2025',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: Color(0xFF989898), width: 1),
            columnWidths: const {
              0: FixedColumnWidth(120.0),
              1: FixedColumnWidth(80.0),
              2: FixedColumnWidth(80.0),
              3: FixedColumnWidth(80.0),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFFF0F0F1)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Payment Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Month',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Year',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              ...tableData.map((row) {
                return TableRow(
                  decoration: const BoxDecoration(color: Colors.white),
                  children: row.entries.map((entry) {

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        entry.value,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabContents = [
      viewBills(),
      paymentHistory(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rebate Request',
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
            SingleChildScrollView(
              scrollDirection:
              _activeTabIndex != 0 ? Axis.horizontal : Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  child: tabContents[_activeTabIndex],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
