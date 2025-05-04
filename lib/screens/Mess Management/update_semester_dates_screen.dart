import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion/screens/Mess%20Management/mess_dashboard.dart';

import '../../utils/bottom_bar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/sidebar.dart';
import '../Examination/examination_dashboard.dart';

class UpdateSemesterDatesScreen extends StatefulWidget {
  const UpdateSemesterDatesScreen({super.key});

  @override
  State<UpdateSemesterDatesScreen> createState() => _UpdateSemesterDatesScreenState();
}

class _UpdateSemesterDatesScreenState extends State<UpdateSemesterDatesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Semester Dates',
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
                    _buildDatePickerFormField(
                        label: 'Start Date *',
                        controller: startDateController),
                    const SizedBox(height: 16),
                    _buildDatePickerFormField(
                        label: 'End Date *',
                        controller: endDateController),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                        },
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
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }
}
