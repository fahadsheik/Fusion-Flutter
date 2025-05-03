import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';

class InviteApplicationsPage extends StatefulWidget {
  const InviteApplicationsPage({super.key});

  @override
  State<InviteApplicationsPage> createState() => _InviteApplicationsPageState();
}

class _InviteApplicationsPageState extends State<InviteApplicationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _selectedApplicationType;
  String? _startDate;
  String? _endDate;

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Invite Applications',
            style: TextStyle(fontWeight: FontWeight.bold),
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormField(
                label: 'Type:',
                labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Select',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Scholarship', child: Text('Scholarship')),
                    DropdownMenuItem(value: 'Award', child: Text('Award')),
                    DropdownMenuItem(value: 'Grant', child: Text('Grant')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedApplicationType = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'Programme:',
                labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Select',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'B.Tech', child: Text('B.Tech')),
                    DropdownMenuItem(value: 'M.Tech', child: Text('M.Tech')),
                    DropdownMenuItem(value: 'Ph.D.', child: Text('Ph.D.')),
                  ],
                  onChanged: (value) {
                    // Handle programme selection
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'Batch:',
                labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Select',
                  ),
                  items: const [
                    DropdownMenuItem(value: '2022-2023', child: Text('2022-2023')),
                    DropdownMenuItem(value: '2023-2024', child: Text('2023-2024')),
                    DropdownMenuItem(value: '2024-2025', child: Text('2024-2025')),
                  ],
                  onChanged: (value) {
                    // Handle batch selection
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'Start Date:',
                labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                child: TextFormField(
                  controller: TextEditingController(text: _startDate),
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'dd/mm/yyyy',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _startDate = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'End Date:',
                labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                child: TextFormField(
                  controller: TextEditingController(text: _endDate),
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'dd/mm/yyyy',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _endDate = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'Remarks:',
                labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Write here..',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedApplicationType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select an application type'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    if (_startDate == null || _endDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select both start and end dates'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    if (DateTime.parse(_endDate!.split('/').reversed.join('-'))
                        .isBefore(DateTime.parse(_startDate!.split('/').reversed.join('-')))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('End date cannot be before start date'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form submitted successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18), // Increase the font size here
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

  Widget _buildFormField({
    required String label,
    required Widget child,
    TextStyle? labelStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
