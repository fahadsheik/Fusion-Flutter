import 'package:flutter/material.dart';
import '../../../../../utils/bottom_bar.dart';
import '../../../../../utils/gesture_sidebar.dart';
import '../../../../../utils/sidebar.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key});

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _historyData = [
    {
      'patientId': '22bcs001',
      'treatedBy': 'Dr GS Sandhu',
      'date': '03/02/2025',
      'details': 'Fever',
      'report': 'Report',
      'prescription': 'view',
    },
    {
      'patientId': '22bcs012',
      'treatedBy': 'Dr GS Sandhu',
      'date': '03/02/2025',
      'details': 'Cold',
      'report': 'Report',
      'prescription': 'view',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Patient History',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue.shade700,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Sidebar(onItemSelected: (index) {}),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Patient ID')),
                      DataColumn(label: Text('Treated By')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Details')),
                      DataColumn(label: Text('Report')),
                      DataColumn(label: Text('Prescription')),
                    ],
                    rows: _historyData.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(data['patientId'])),
                          DataCell(Text(data['treatedBy'])),
                          DataCell(Text(data['date'])),
                          DataCell(Text(data['details'])),
                          DataCell(TextButton(
                            onPressed: () => _viewReport(data['patientId']),
                            child: const Text('View'),
                          )),
                          DataCell(TextButton(
                            onPressed: () => _viewPrescription(data['patientId']),
                            child: const Text('View'),
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }

  void _viewReport(String patientId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report for Patient $patientId'),
        content: const Text('Report details will be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _viewPrescription(String patientId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Prescription for Patient $patientId'),
        content: const Text('Prescription details will be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}