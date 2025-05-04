import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion/screens/Mess%20Management/mess_dashboard.dart';

import '../../utils/bottom_bar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/sidebar.dart';
import '../Examination/examination_dashboard.dart';

class ViewRegistrationsScreen extends StatefulWidget {
  const ViewRegistrationsScreen({super.key});

  @override
  State<ViewRegistrationsScreen> createState() => _ViewRegistrationsScreenState();
}

class _ViewRegistrationsScreenState extends State<ViewRegistrationsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget viewRegistrations() {
    final List<Map<String, String>> tableData = [
      {
        'Student Name': 'Agrim Gupta',
        'Roll Number': '22BCS016',
        'Mess': 'Mess 1',
        'Status': '0',
      },
      {
        'Student Name': 'Agrim Gupta',
        'Roll Number': '22BCS016',
        'Mess': 'Mess 1',
        'Status': '2',
      },
      {
        'Student Name': 'Agrim Gupta',
        'Roll Number': '22BCS016',
        'Mess': 'Mess 1',
        'Status': '2',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Color(0xFF989898), width: 1),
        columnWidths: const {
          0: FixedColumnWidth(120.0),
          1: FixedColumnWidth(100.0),
          2: FixedColumnWidth(80.0),
          3: FixedColumnWidth(120.0),
        },
        children: [
          const TableRow(
            decoration: BoxDecoration(color: Color(0xFFF0F0F1)),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Student Name',
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
                  'Mess',
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
            ],
          ),
          ...tableData.map((row) {
            return TableRow(
              decoration: const BoxDecoration(color: Colors.white),
              children: row.entries.map((entry) {
                if (entry.key == 'Status') {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: buildStatusWidget(row['Status']!),
                    ),
                  );
                } else {
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
      ),
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
        statusText = 'Registered';
        break;
      case '0':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red;
        statusText = 'Deregistered';
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
    return GestureSidebar(
      scaffoldKey: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'View Registrations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
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
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.blue),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
          ],
        ),
        drawer: Sidebar(
          onItemSelected: (index) {
            Navigator.pop(context);
            if (index == 57) {
              // Already on Verify Grades screen
            } else if (index == 0) {
              Navigator.pop(context);
            } else {
            }
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter search term',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Search', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    viewRegistrations(),
                  ],
                )
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }
}
