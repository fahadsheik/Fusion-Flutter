import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion/screens/Mess%20Management/mess_dashboard.dart';
import 'package:path/path.dart' as path;
import '../../utils/bottom_bar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/sidebar.dart';
import '../Examination/examination_dashboard.dart';

class DeregistrationScreen extends StatefulWidget {
  const DeregistrationScreen({super.key});

  @override
  State<DeregistrationScreen> createState() => _DeregistrationScreenState();
}

class _DeregistrationScreenState extends State<DeregistrationScreen> {

  String? selectedSemester;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    TextEditingController rollNumberController = TextEditingController();
    TextEditingController batchController = TextEditingController();
    TextEditingController deregistrationRemarksController = TextEditingController();

    void showSnackBar(String message, {bool isError = false}) {
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

    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

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
    
    return GestureSidebar(
      scaffoldKey: scaffoldKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Deregistration Form',
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
            if (index == 59) {
              // Already on Verify Grades screen
            } else if (index == 0) {
              Navigator.pop(context);
            } else {
              showSnackBar('Navigating to ${_getScreenName(index)}');
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
                    _buildTextFormField(
                        label: 'Roll Number *',
                        hintText: 'Enter roll number',
                        controller: rollNumberController),
                    const SizedBox(height: 16),
                    _buildTextFormField(
                        label: 'Batch *',
                        hintText: 'Enter batch',
                        controller: batchController),
                    const SizedBox(height: 16),
                    buildDropdown(
                      label: 'Semester',
                      selectedValue: selectedSemester,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSemester = newValue;
                        });
                      },
                      items: ['1', '2', '3', '4', '5', '6', '7', '8'],
                    ),
                    const SizedBox(height: 16),
                    _buildTextFormField(
                        label: 'Deregistration remarks *',
                        hintText: 'Enter remarks',
                        controller: deregistrationRemarksController),
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
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
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
