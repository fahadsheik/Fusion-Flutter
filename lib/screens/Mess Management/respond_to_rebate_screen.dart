import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mess_dashboard.dart';

class RespondToRebateScreen extends StatefulWidget {
  const RespondToRebateScreen({super.key});

  @override
  State<RespondToRebateScreen> createState() => _RespondToRebateScreenState();
}

class _RespondToRebateScreenState extends State<RespondToRebateScreen> {

  Widget deregistrationRequest(){
    final List<Map<String, String>> tableData = [
      {
        'Date': '2025-4-21',
        'Roll Number': '22BCS016',
        'Purpose': "Going home",
        'From': '2025-4-29',
        'To': '2025-5-25',
        'Remark': 'NA',
        'Actions':''
      },
      {
        'Date': '2025-4-21',
        'Roll Number': '22BCS016',
        'Purpose': "Going home",
        'From': '2025-4-29',
        'To': '2025-5-25',
        'Remark': 'NA',
        'Actions':''
      },
      {
        'Date': '2025-4-21',
        'Roll Number': '22BCS016',
        'Purpose': "Going home",
        'From': '2025-4-29',
        'To': '2025-5-25',
        'Remark': 'NA',
        'Actions':''
      }
    ];

    return Table(
      border: TableBorder.all(color: Color(0xFF989898), width: 1),
      columnWidths: const {
        0: FixedColumnWidth(100.0),
        1: FixedColumnWidth(100.0),
        2: FixedColumnWidth(100.0),
        3: FixedColumnWidth(100.0),
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
                'Date',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
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
                'Purpose',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'From',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'To',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Respond to Rebate',
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
            SingleChildScrollView(
              scrollDirection:
              Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  child: deregistrationRequest(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
