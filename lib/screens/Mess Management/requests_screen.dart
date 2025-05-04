import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mess_dashboard.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  int _activeTabIndex = 0;

  final List<String> _tabs = ['Registration', 'Deregistration', 'Update'];

  Widget registrationRequest(){
    final List<Map<String, String>> tableData = [
      {
        'Name': 'Agrim Gupta',
        'Transaction Number': 'TX12554',
        'Image': 'View',
        'Amount': '100',
        'Start Date':'2025-04-21',
        'Payment Date':'2025-04-21',
        'Remark': 'NA',
        'Status': '0',
        'Actions':''
      },
      {
        'Name': 'Agrim Gupta',
        'Transaction Number': 'TX12554',
        'Image': 'View',
        'Amount': '100',
        'Start Date':'2025-04-21',
        'Payment Date':'2025-04-21',
        'Remark': 'NA',
        'Status': '1',
        'Actions':''
      },
      {
        'Name': 'Agrim Gupta',
        'Transaction Number': 'TX12554',
        'Image': 'View',
        'Amount': '100',
        'Start Date':'2025-04-21',
        'Payment Date':'2025-04-21',
        'Remark': 'NA',
        'Status': '2',
        'Actions':''
      },
    ];

    return Table(
      border: TableBorder.all(color: Color(0xFF989898), width: 1),
      columnWidths: const {
        0: FixedColumnWidth(100.0),
        1: FixedColumnWidth(100.0),
        2: FixedColumnWidth(100.0),
        3: FixedColumnWidth(80.0),
        4: FixedColumnWidth(100.0),
        5: FixedColumnWidth(100.0),
        6: FixedColumnWidth(120.0),
        7: FixedColumnWidth(100.0),
        8: FixedColumnWidth(180.0),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFF0F0F1)),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Transaction Number',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Image',
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
                'Start Date',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
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
                'Remark',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Actions',
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
              if (entry.key == 'Image') {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        color: Colors.indigo,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              else if (entry.key == 'Status') {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: buildStatusWidget(row['Status']!),
                  ),
                );
              }
              else if (entry.key == 'Actions') {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildUpdateStatusWidget('2'),
                        SizedBox(width: 8,),
                        buildUpdateStatusWidget('0'),
                      ],
                    ),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    entry.value,
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }).toList(),
          );
        }).toList(),
      ],
    );
  }

  Widget deregistrationRequest(){
    final List<Map<String, String>> tableData = [
      {
        'Roll Number': '22BCS016',
        'Remark': 'NA',
        'Actions':''
      },
      {
        'Roll Number': '22BCS016',
        'Remark': 'NA',
        'Actions':''
      },
      {
        'Roll Number': '22BCS016',
        'Remark': 'NA',
        'Actions':''
      },
    ];

    return Table(
      border: TableBorder.all(color: Color(0xFF989898), width: 1),
      columnWidths: const {
        0: FixedColumnWidth(100.0),
        1: FixedColumnWidth(100.0),
        2: FixedColumnWidth(180.0),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFF0F0F1)),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Roll Number',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Remark',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Actions',
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
              if (entry.key == 'Actions') {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildUpdateStatusWidget('2'),
                        SizedBox(width: 8,),
                        buildUpdateStatusWidget('0'),
                      ],
                    ),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    entry.value,
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }).toList(),
          );
        }).toList(),
      ],
    );
  }

  Widget updateRegistration(){
    final List<Map<String, String>> tableData = [
      {
        'Roll Number': '22BCS016',
        'Transaction Number': 'TX12554',
        'Image': 'View',
        'Amount': '100',
        'Payment Date':'2025-04-21',
        'Remark': 'NA',
        'Actions':''
      },
      {
        'Roll Number': '22BCS016',
        'Transaction Number': 'TX12554',
        'Image': 'View',
        'Amount': '100',
        'Payment Date':'2025-04-21',
        'Remark': 'NA',
        'Actions':''
      },
      {
        'Roll Number': '22BCS016',
        'Transaction Number': 'TX12554',
        'Image': 'View',
        'Amount': '100',
        'Payment Date':'2025-04-21',
        'Remark': 'NA',
        'Actions':''
      },
    ];

    return Table(
      border: TableBorder.all(color: Color(0xFF989898), width: 1),
      columnWidths: const {
        0: FixedColumnWidth(100.0),
        1: FixedColumnWidth(100.0),
        2: FixedColumnWidth(100.0),
        3: FixedColumnWidth(80.0),
        4: FixedColumnWidth(100.0),
        5: FixedColumnWidth(100.0),
        6: FixedColumnWidth(180.0),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFF0F0F1)),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Roll Number',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Transaction Number',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Image',
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
                'Payment Date',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Remark',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Actions',
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
              if (entry.key == 'Image') {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        color: Colors.indigo,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              else if (entry.key == 'Actions') {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildUpdateStatusWidget('2'),
                        SizedBox(width: 8,),
                        buildUpdateStatusWidget('0'),
                      ],
                    ),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    entry.value,
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }).toList(),
          );
        }).toList(),
      ],
    );
  }

  Widget buildStatusWidget(String status) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case '2':
        backgroundColor = Colors.lightGreen.shade100;
        textColor = Colors.green;
        statusText = 'Accepted';
        break;
      case '1':
        backgroundColor = Colors.grey.shade300;
        textColor = Colors.grey;
        statusText = 'Pending';
        break;
      case '0':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red;
        statusText = 'Rejected';
        break;
      default:
        backgroundColor = Colors.grey.shade300;
        textColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: textColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            statusText,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 12
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUpdateStatusWidget(String status) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case '2':
        backgroundColor = Colors.lightGreen.shade100;
        textColor = Colors.green;
        statusText = 'Accept';
        break;
      case '0':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red;
        statusText = 'Reject';
        break;
      default:
        backgroundColor = Colors.grey.shade300;
        textColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: textColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            statusText,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> tabContents = [
      registrationRequest(),
      deregistrationRequest(),
      updateRegistration()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Requests',
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
              Axis.horizontal,
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
