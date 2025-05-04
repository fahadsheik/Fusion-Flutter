import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';

class ApplicationStatusConvenerPage extends StatefulWidget {
  const ApplicationStatusConvenerPage({super.key});

  @override
  State<ApplicationStatusConvenerPage> createState() => _ApplicationStatusConvenerPageState();
}

class _ApplicationStatusConvenerPageState extends State<ApplicationStatusConvenerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _tabs = ['MCM Scholarship', 'Convocation Medals'];
  int _selectedTabIndex = 0; // 0: MCM Scholarship, 1: Convocation Medals
  String? selectedAward; // Moved to state class for persistence

  // Move mcmData to the state class
  List<Map<String, dynamic>> mcmData = [
    {
      'Student ID': '22BCS184',
      'Category': 'GEN',
      'Income': '100000',
      'CPI': '8.2',
      'Files': 'Download',
      'Status': 'Pending'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'GEN',
      'Income': '100000',
      'CPI': '8',
      'Files': 'Download',
      'Status': 'Approved'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'GEN',
      'Income': '100000',
      'CPI': '9',
      'Files': 'Download',
      'Status': 'Rejected'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'GEN',
      'Income': '100000',
      'CPI': '9.5',
      'Files': 'Download',
      'Status': 'Rejected'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'OBC',
      'Income': '100000',
      'CPI': '9.7',
      'Files': 'Download',
      'Status': 'Approved'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'OBC',
      'Income': '100000',
      'CPI': '9.8',
      'Files': 'Download',
      'Status': 'Approved'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'OBC',
      'Income': '100000',
      'CPI': '8.6',
      'Files': 'Download',
      'Status': 'Rejected'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'OBC',
      'Income': '100000',
      'CPI': '8.9',
      'Files': 'Download',
      'Status': 'Rejected'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'SC',
      'Income': '100000',
      'CPI': '9.1',
      'Files': 'Download',
      'Status': 'Rejected'
    },
    {
      'Student ID': '22BCS184',
      'Category': 'ST',
      'Income': '100000',
      'CPI': '8.5',
      'Files': 'Download',
      'Status': 'Rejected'
    },
  ];

  // Move convocationData to the state class
  List<Map<String, dynamic>> convocationData = [
    {'Student ID': '22BCS184', 'Award': 'Director\'s Gold Medal', 'CPI': '9.8', 'Files': 'Download', 'Status': 'Approved'},
    {'Student ID': '22BCS185', 'Award': 'Academic Excellence Award', 'CPI': '9.5', 'Files': 'Download', 'Status': 'Pending'},
    {'Student ID': '22BCS186', 'Award': 'Director\'s Gold Medal', 'CPI': '9.7', 'Files': 'Download', 'Status': 'Rejected'},
    {'Student ID': '22BCS187', 'Award': 'Academic Excellence Award', 'CPI': '9.6', 'Files': 'Download', 'Status': 'Approved'},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.scaleDown, // Ensure the text scales down if needed
            child: Text(
              'Application Status (Convener)',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.blue),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ],
        ),
        drawer: Sidebar(
          onItemSelected: (index) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Navigating to item $index'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
        body: Column(
          children: [
            const SizedBox(height: 16), // Margin below the app bar

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  return _buildTabButton(
                    index: index,
                    label: _tabs[index],
                    icon: index == 0 ? Icons.school : Icons.emoji_events,
                  );
                }),
              ),
            ),

            const SizedBox(height: 8), // Space below the tabs
            const SizedBox(height: 16), // Margin between tabs and content

            Flexible(
              fit: FlexFit.loose,
              child: _selectedTabIndex == 0
                  ? _buildMCMContent()
                  : _buildConvocationContent(),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {
          if (_selectedTabIndex != index) {
            setState(() {
              _selectedTabIndex = index;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedTabIndex == index ? Colors.blue : Colors.blue.shade50,
          foregroundColor:
              _selectedTabIndex == index ? Colors.white : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _selectedTabIndex == index ? Colors.white : Colors.blue,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: _selectedTabIndex == index ? Colors.white : Colors.blue,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMCMContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.all(16.0), // Outer spacing
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAlias,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.blue),
          dataRowColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? Colors.blue.shade100
                : const Color.fromARGB(195, 255, 255, 255),
          ),
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
            verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
            top: BorderSide(color: Colors.grey.shade300, width: 1),
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            left: BorderSide(color: Colors.grey.shade300, width: 1),
            right: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          columnSpacing: 20,
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          dataTextStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          columns: [
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text('Student ID', textAlign: TextAlign.center),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text('Category', textAlign: TextAlign.center),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text('Income', textAlign: TextAlign.center),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text('CPI', textAlign: TextAlign.center),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text('Files', textAlign: TextAlign.center),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text('Status', textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
          rows: mcmData.map((data) {
            return DataRow(
              cells: [
                DataCell(Center(child: Text(data['Student ID']))),
                DataCell(Center(child: Text(data['Category']))),
                DataCell(Center(child: Text(data['Income']))),
                DataCell(Center(child: Text(data['CPI']))),
                DataCell(
                  Center(
                    child: ElevatedButton.icon(
                      // ... your button code ...
                      onPressed: () {},
                      icon: const Icon(Icons.download,
                          size: 16, color: Colors.blue),
                      label: const Text('Download',
                          style: TextStyle(color: Colors.blue)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _toggleStatus(data); // Call the toggle method when tapped
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(data['Status']),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          data['Status'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _toggleStatus(Map<String, dynamic> data) {
    setState(() {
      if (data['Status'] == 'Rejected') {
        data['Status'] = 'Approved';
      } else if (data['Status'] == 'Approved') {
        data['Status'] = 'Pending';
      } else if (data['Status'] == 'Pending') {
        data['Status'] = 'Rejected';
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green.shade400;
      case 'Rejected':
        return Colors.red.shade400;
      case 'Pending':
        return Colors.orange.shade400;
      default:
        return Colors.grey.shade400;
    }
  }

  Widget _buildConvocationContent() {
    final filteredData = selectedAward == null
        ? convocationData
        : convocationData.where((data) => data['Award'] == selectedAward).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const Text(
                'Award:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  value: selectedAward,
                  hint: const Text('Select Award'),
                  items: const [
                    DropdownMenuItem(value: 'Director\'s Gold Medal', child: Text('Director\'s Gold Medal')),
                    DropdownMenuItem(value: 'Academic Excellence Award', child: Text('Academic Excellence Award')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedAward = value; // Update the selected award
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              clipBehavior: Clip.antiAlias,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.blue),
                dataRowColor: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.selected)
                      ? Colors.blue.shade100
                      : const Color.fromARGB(195, 255, 255, 255),
                ),
                border: TableBorder.all(color: Colors.grey.shade300),
                columnSpacing: 20,
                headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                dataTextStyle: const TextStyle(fontSize: 14, color: Colors.black),
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Student ID', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Award', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('CPI', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Files', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Status', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ],
                rows: filteredData.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Center(child: Text(data['Student ID']))),
                      DataCell(SizedBox(width: 200, child: Center(child: Text(data['Award'])))),
                      DataCell(Center(child: Text(data['CPI']))),
                      DataCell(
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Handle file download
                            },
                            icon: const Icon(Icons.download, size: 16, color: Colors.blue),
                            label: const Text('Download', style: TextStyle(color: Colors.blue)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade50,
                              foregroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              _toggleStatus(data); // Call the toggle method when tapped
                            },
                            child: Tooltip(
                              message: 'Click to toggle status', // Add tooltip
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(data['Status']),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  data['Status'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}