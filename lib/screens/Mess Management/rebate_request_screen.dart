import 'package:flutter/material.dart';

import 'mess_dashboard.dart';

class RebateRequestScreen extends StatefulWidget {
  const RebateRequestScreen({super.key});

  @override
  State<RebateRequestScreen> createState() => _RebateRequestScreenState();
}

class _RebateRequestScreenState extends State<RebateRequestScreen> {
  int _activeTabIndex = 0;
  TextEditingController rebatePurposeController = TextEditingController();
  TextEditingController rebateToDateController = TextEditingController();
  TextEditingController rebateFromDateController = TextEditingController();
  String? _selectedMess;

  final List<String> _tabs = ['Apply for Rebate', 'Rebate Status'];

  Widget applyForRebate() {
    return Column(
      children: [
        buildDropdown(
          label: 'Select Mess',
          selectedValue: _selectedMess,
          onChanged: (String? newValue) {
            setState(() {
              _selectedMess = newValue;
            });
          },
          items: ['Mess 1', 'Mess 2'],
        ),
        const SizedBox(height: 16),
        _buildDatePickerFormField(
            label: 'Rebate From *', controller: rebateFromDateController),
        const SizedBox(height: 16),
        _buildDatePickerFormField(
            label: 'Rebate To *', controller: rebateToDateController),
        const SizedBox(height: 16),
        _buildTextFormField(
            label: 'Purpose *', controller: rebatePurposeController, hintText: 'Enter purpose'),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }

  Widget rebateStatus() {
    final List<Map<String, String>> tableData = [
      {
        'Date': '2025-04-21',
        'Type': 'Vacation',
        'From': '2025-04-30',
        'To': '2025-04-23',
        'Status': '0',
      },
      {
        'Date': '2025-04-21',
        'Type': 'Vacation',
        'From': '2025-04-30',
        'To': '2025-04-23',
        'Status': '1',
      },
      {
        'Date': '2025-04-21',
        'Type': 'Vacation',
        'From': '2025-04-30',
        'To': '2025-04-23',
        'Status': '2',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Color(0xFF989898), width: 1),
        columnWidths: const {
          0: FixedColumnWidth(100.0),
          1: FixedColumnWidth(80.0),
          2: FixedColumnWidth(100.0),
          3: FixedColumnWidth(100.0),
          4: FixedColumnWidth(120.0),
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
                  'Type',
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

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _getScreenName(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Orders';
      case 2:
        return 'Announcement';
      case 3:
        return 'Submit Grades';
      case 4:
        return 'Verify Grades';
      case 5:
        return 'Generate Transcript';
      case 6:
        return 'Profile';
      case 7:
        return 'Settings';
      case 8:
        return 'Help';
      case 9:
        return 'Log out';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabContents = [
      applyForRebate(),
      rebateStatus(),
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

  Widget _buildDatePickerFormField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'YY/MM/DD',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: const Icon(
              Icons.calendar_today,
              size: 16,
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              controller.text =
              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
            }
          },
        ),
      ],
    );
  }

  Widget buildDropdown({
    required String label,
    required List<String> items,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            underline: const SizedBox(),
            hint: const Text('Select an option'),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
