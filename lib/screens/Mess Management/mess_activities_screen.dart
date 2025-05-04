import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'mess_dashboard.dart';

class MessActivitiesScreen extends StatefulWidget {
  const MessActivitiesScreen({super.key});

  @override
  State<MessActivitiesScreen> createState() => _MessActivitiesScreenState();
}

class _MessActivitiesScreenState extends State<MessActivitiesScreen> {
  int _activeTabIndex = 0;

  final TextEditingController _fileTextController = TextEditingController();
  bool _isFileSelected = false;
  PlatformFile? _selectedFile;
  bool _isLoading = false;

  final List<String> _tabs = ['Bill Base', 'Update Bill', 'View Bill'];
  TextEditingController baseAmountController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController newAmountController = TextEditingController();
  String? selectedMonth;
  String? selectedYear;

  Future<void> _selectFile() async {
    try {
      setState(() {
        _isLoading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls', 'csv'],
        allowMultiple: false,
      );

      setState(() {
        _isLoading = false;
      });

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
          _isFileSelected = true;
          _fileTextController.text = _selectedFile!.name;
        });

        _showSnackBar('File selected: ${_selectedFile!.name}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      _showSnackBar('Error picking file: $e', isError: true);
    }
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

  Widget billBase() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildTextFormField(
                label: 'Base Amount *',
                hintText: 'Enter new base amount',
                controller: baseAmountController,
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 80,
              height: 50,
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
                child: const Text('Update'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildFormField(
                label: 'Upload Monthly Bill *',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _selectFile,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Text(
                                  _fileTextController.text.isEmpty
                                      ? 'No file chosen'
                                      : _fileTextController.text,
                                  style: TextStyle(
                                    color: _fileTextController.text.isEmpty
                                        ? Colors.grey.shade600
                                        : Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(7.0),
                                  bottomRight: Radius.circular(7.0),
                                ),
                              ),
                              child: TextButton(
                                onPressed: _selectFile,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                ),
                                child: Text(
                                  'Browse',
                                  style: TextStyle(color: Colors.blue.shade700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 12, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            'Accepts .xlsx, .xls or .csv files only',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isFileSelected && _selectedFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getFileIcon(_selectedFile!.name),
                        color: _selectedFile!.name.endsWith('.csv')
                            ? Colors.blue
                            : Colors.green,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedFile!.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              _formatFileSize(_selectedFile!.size),
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close,
                            color: Colors.red, size: 20),
                        onPressed: () {
                          setState(() {
                            _isFileSelected = false;
                            _fileTextController.text = '';
                            _selectedFile = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(width: 16),
            SizedBox(
              width: 80,
              height: 50,
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
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget updateBill() {
    return Column(
      children: [
        _buildTextFormField(
          label: 'Roll Number *',
          hintText: 'Enter Roll no.',
          controller: rollNumberController,
        ),
        const SizedBox(
          height: 16,
        ),
        _buildTextFormField(
          label: 'New Amount *',
          hintText: 'Enter new amount',
          controller: newAmountController,
        ),
        const SizedBox(
          height: 16,
        ),
        buildDropdown(
          label: 'Month',
          items: [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ],
          selectedValue: selectedMonth != null &&
                  [
                    'January',
                    'February',
                    'March',
                    'April',
                    'May',
                    'June',
                    'July',
                    'August',
                    'September',
                    'October',
                    'November',
                    'December'
                  ].contains(selectedMonth)
              ? selectedMonth
              : null,
          onChanged: (String? newValue) {
            setState(() {
              selectedMonth = newValue;
            });
          },
        ),
        const SizedBox(
          height: 16,
        ),
        buildDropdown(
          label: 'Year',
          items: ['2025', '2026'],
          selectedValue: selectedYear,
          onChanged: (String? newValue) {
            setState(() {
              selectedYear = newValue;
            });
          },
        ),
        const SizedBox(
          height: 24,
        ),
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
            child: const Text('Update'),
          ),
        ),
      ],
    );
  }

  Widget viewBills() {
    final List<Map<String, String>> tableData = [
      {
        'Name': 'Agrim Gupta',
        'Roll Number': '22BCS016',
        'Program': 'B.Tech',
        'Status': 'Registered',
        'Balance': '1000',
        'Mess': 'Mess 1',
        'View Bill': 'View Bill',
        'View Payment': 'View Payment'
      },
      {
        'Name': 'Agrim Gupta',
        'Roll Number': '22BCS016',
        'Program': 'B.Tech',
        'Status': 'Registered',
        'Balance': '1000',
        'Mess': 'Mess 1',
        'View Bill': 'View Bill',
        'View Payment': 'View Payment'
      },
      {
        'Name': 'Agrim Gupta',
        'Roll Number': '22BCS016',
        'Program': 'B.Tech',
        'Status': 'Registered',
        'Balance': '1000',
        'Mess': 'Mess 1',
        'View Bill': 'View Bill',
        'View Payment': 'View Payment'
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Color(0xFF989898), width: 1),
        columnWidths: const {
          0: FixedColumnWidth(100.0),
          1: FixedColumnWidth(100.0),
          2: FixedColumnWidth(80.0),
          3: FixedColumnWidth(100.0),
          4: FixedColumnWidth(70.0),
          5: FixedColumnWidth(70.0),
          6: FixedColumnWidth(100.0),
          7: FixedColumnWidth(130.0),
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
                  'Roll Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Program',
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
                  'Balance',
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
                  'View Bill',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'View Payment',
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
                if (entry.key == 'View Bill' || entry.key == 'View Payment') {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: buildStatusWidget(entry.value),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
      child: Text(
        status,
        style: const TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabContents = [billBase(), updateBill(), viewBills()];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mess Activities',
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
                  _activeTabIndex == 2 ? Axis.horizontal : Axis.vertical,
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
          maxLines: 1,
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

  IconData _getFileIcon(String fileName) {
    String extension = path.extension(fileName).toLowerCase();

    if (extension == '.csv') {
      return Icons.description;
    } else if (extension == '.xlsx' || extension == '.xls') {
      return Icons.table_chart;
    } else {
      return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      double kb = bytes / 1024;
      return '${kb.toStringAsFixed(1)} KB';
    } else {
      double mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(1)} MB';
    }
  }

  Widget _buildFormField({required String label, required Widget child}) {
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
        child,
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
}
