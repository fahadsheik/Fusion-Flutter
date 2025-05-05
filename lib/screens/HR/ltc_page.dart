import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/bottom_bar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/sidebar.dart'; // Import the sidebar
import 'leave_page.dart';
import 'CpdaAdvanceFormScreen.dart';
import 'CpdaClaim.dart';

class LtcFormScreen extends StatefulWidget {
  @override
  _LtcFormScreenState createState() => _LtcFormScreenState();
}

class _LtcFormScreenState extends State<LtcFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _blockYearController = TextEditingController();
  final TextEditingController _pfNumberController = TextEditingController();
  final TextEditingController _basicPayController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _leaveAvailableController =
      TextEditingController();
  final TextEditingController _natureOfLeaveController =
      TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _ltcPlaceController = TextEditingController();
  final TextEditingController _travelModeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _advanceAmountController =
      TextEditingController();
  final TextEditingController _advanceTakenDateController =
      TextEditingController();
  final TextEditingController _previousAdvanceDateController =
      TextEditingController();
  final TextEditingController _adjustedMonthController =
      TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _recommendationController =
      TextEditingController();
  final TextEditingController _receiverUsernameController =
      TextEditingController();
  final TextEditingController _receiverDesignationController =
      TextEditingController();

  DateTime? _leaveFromDate;
  DateTime? _leaveToDate;
  DateTime? _familyDepartureDate;

  int selectedTab = 0;

  List<Map<String, String>> familyMembersAvailing = [];
  List<Map<String, String>> dependentMembers = [];

  String _formatDate(DateTime? date) {
    if (date == null) return "dd/mm/yyyy";
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      Function(DateTime) onSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        onSelected(picked);
      });
    }
  }

  void _checkForm() {
    if (_blockYearController.text.isEmpty ||
        _pfNumberController.text.isEmpty ||
        _basicPayController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _designationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form looks good!')),
      );
    }
  }

  void _submitForm() {
    // For now, just show a confirmation message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Submission"),
        content: Text("Are you sure you want to submit the LTC form?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Form Submitted Successfully")),
              );
              _clearForm();
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }

  void _clearForm() {
    _blockYearController.clear();
    _pfNumberController.clear();
    _basicPayController.clear();
    _nameController.clear();
    _designationController.clear();
    _departmentController.clear();
    _leaveAvailableController.clear();
    _natureOfLeaveController.clear();
    _purposeController.clear();
    _ltcPlaceController.clear();
    _travelModeController.clear();
    _addressController.clear();
    _advanceAmountController.clear();
    _advanceTakenDateController.clear();
    _previousAdvanceDateController.clear();
    _adjustedMonthController.clear();
    _contactPhoneController.clear();
    _recommendationController.clear();
    _receiverUsernameController.clear();
    _receiverDesignationController.clear();
    _leaveFromDate = null;
    _leaveToDate = null;
    _familyDepartureDate = null;
    familyMembersAvailing.clear();
    dependentMembers.clear();
    setState(() {});
  }

  // Helper method to create consistent input decorations with a modern look
  InputDecoration getInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.blue.shade700),
      filled: true,
      fillColor: Colors.grey.shade50,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.red.shade600, width: 2),
      ),
    );
  }

  // Helper method for building form fields with consistent styling
  Widget _buildFormField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'LTC Management',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Sidebar(), // Use the Sidebar from Home page
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 10.0, top: 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Check if screen size is small
                  final isSmallScreen = constraints.maxWidth < 400;
                  return isSmallScreen
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildTabButton("LTC Form", 0),
                                _buildTabButton("Requests", 1),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildTabButton("Inbox", 2),
                                _buildTabButton("Archive", 3),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTabButton("LTC Form", 0),
                            _buildTabButton("Requests", 1),
                            _buildTabButton("Inbox", 2),
                            _buildTabButton("Archive", 3),
                          ],
                        );
                },
              ),
            ),
          ),
          Expanded(child: _buildTabView()),
        ],
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 1),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;

    return TextButton(
      onPressed: () => setState(() => selectedTab = index),
      style: TextButton.styleFrom(
        backgroundColor:
            isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTabView() {
    switch (selectedTab) {
      case 1:
        return _buildRequestList();
      case 2:
        return _buildInboxList();
      case 3:
        return _buildArchiveList();
      default:
        return _buildForm();
    }
  }

  Widget _buildForm() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            label: "Block Year",
            child: TextField(
              controller: _blockYearController,
              decoration:
                  getInputDecoration("Enter Block Year", Icons.date_range),
            ),
          ),
          _buildFormField(
            label: "Provident Fund Number",
            child: TextField(
              controller: _pfNumberController,
              decoration: getInputDecoration(
                  "Enter PF Number", Icons.confirmation_number),
            ),
          ),
          _buildFormField(
            label: "Basic Pay",
            child: TextField(
              controller: _basicPayController,
              decoration: getInputDecoration("Enter Basic Pay", Icons.payments),
            ),
          ),
          _buildFormField(
            label: "1. Enter your name",
            child: TextField(
              controller: _nameController,
              decoration: getInputDecoration("Enter your name", Icons.person),
            ),
          ),
          _buildFormField(
            label: "2. Designation",
            child: TextField(
              controller: _designationController,
              decoration: getInputDecoration("Enter Designation", Icons.badge),
            ),
          ),
          _buildFormField(
            label: "3. Department",
            child: TextField(
              controller: _departmentController,
              decoration:
                  getInputDecoration("Enter Department", Icons.apartment),
            ),
          ),
          _buildFormField(
            label: "4(a) Whether leave is available for availing LTC?",
            child: TextField(
              controller: _leaveAvailableController,
              decoration:
                  getInputDecoration("Enter Availability", Icons.question_mark),
            ),
          ),
          _buildFormField(
            label: "4(b)(i) Leave From Date",
            child: GestureDetector(
              onTap: () => _selectDate(
                  context, _leaveFromDate, (date) => _leaveFromDate = date),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                height: 55,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blueAccent),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        _formatDate(_leaveFromDate),
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                    Icon(Icons.calendar_view_month, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
          _buildFormField(
            label: "4(b)(i) Leave To Date",
            child: GestureDetector(
              onTap: () => _selectDate(
                  context, _leaveToDate, (date) => _leaveToDate = date),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                height: 55,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blueAccent),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        _formatDate(_leaveToDate),
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                    Icon(Icons.calendar_view_month, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
          _buildFormField(
            label: "4(b)(ii) Family Departure Date",
            child: GestureDetector(
              onTap: () => _selectDate(context, _familyDepartureDate,
                  (date) => _familyDepartureDate = date),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                height: 55,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blueAccent),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        _formatDate(_familyDepartureDate),
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                    Icon(Icons.calendar_view_month, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
          _buildFormField(
            label: "4(c) Nature of Leave",
            child: TextField(
              controller: _natureOfLeaveController,
              decoration:
                  getInputDecoration("Enter Nature of Leave", Icons.style),
            ),
          ),
          _buildFormField(
            label: "4(d) Purpose",
            child: TextField(
              controller: _purposeController,
              decoration: getInputDecoration("Enter Purpose", Icons.edit_note),
            ),
          ),
          _buildFormField(
            label: "5. Place - Home Town / Elsewhere",
            child: TextField(
              controller: _ltcPlaceController,
              decoration: getInputDecoration("Enter Place", Icons.place),
            ),
          ),
          _buildFormField(
            label: "6. Mode of Travel",
            child: TextField(
              controller: _travelModeController,
              decoration:
                  getInputDecoration("Enter Mode of Travel", Icons.train),
            ),
          ),
          _buildFormField(
            label: "7. Address During Leave",
            child: TextField(
              controller: _addressController,
              decoration: getInputDecoration("Enter Address", Icons.home),
            ),
          ),
          SizedBox(height: 20),
          Text("8(ii) Family Members Availing LTC",
              style: TextStyle(fontWeight: FontWeight.bold)),
          _buildFamilyTable(
              familyMembersAvailing, ['Index', 'Full Name', 'Age']),
          TextButton(
              onPressed: () => _addFamilyRow(familyMembersAvailing),
              child: Text("+ Add Member")),
          SizedBox(height: 10),
          Text("8(iii) Dependent Family Members",
              style: TextStyle(fontWeight: FontWeight.bold)),
          _buildFamilyTable(dependentMembers,
              ['Index', 'Full Name', 'Age', 'Reason for Dependency']),
          TextButton(
              onPressed: () =>
                  _addFamilyRow(dependentMembers, isDependent: true),
              child: Text("+ Add Dependent")),
          SizedBox(height: 20),
          _buildFormField(
            label: "9. Amount of advance required (if any)",
            child: TextField(
              controller: _advanceAmountController,
              decoration:
                  getInputDecoration("Enter Advance Amount", Icons.money),
            ),
          ),
          _buildFormField(
            label: "Advance Taken On Date",
            child: TextField(
              controller: _advanceTakenDateController,
              decoration: getInputDecoration("Enter Date", Icons.date_range),
            ),
          ),
          _buildFormField(
            label: "Previous LTC Advance Taken On",
            child: TextField(
              controller: _previousAdvanceDateController,
              decoration:
                  getInputDecoration("Enter Previous Date", Icons.history),
            ),
          ),
          _buildFormField(
            label: "Adjusted in Month Of",
            child: TextField(
              controller: _adjustedMonthController,
              decoration: getInputDecoration("Enter Month", Icons.event),
            ),
          ),
          _buildFormField(
            label: "10. Contact Phone Number",
            child: TextField(
              controller: _contactPhoneController,
              decoration: getInputDecoration("Enter Phone Number", Icons.phone),
            ),
          ),
          _buildFormField(
            label: "11. Specific Recommendation by Head",
            child: TextField(
              controller: _recommendationController,
              decoration:
                  getInputDecoration("Enter Recommendation", Icons.comment),
            ),
          ),
          _buildFormField(
            label: "Receiver Username",
            child: TextField(
              controller: _receiverUsernameController,
              decoration:
                  getInputDecoration("Enter Username", Icons.account_circle),
            ),
          ),
          _buildFormField(
            label: "Receiver Designation",
            child: TextField(
              controller: _receiverDesignationController,
              decoration: getInputDecoration("Enter Designation", Icons.work),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                // Wide screen - buttons side by side
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _checkForm,
                      icon: Icon(Icons.check_circle, color: Colors.white),
                      label: Text(
                        "Check Form",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: Icon(Icons.send, color: Colors.white),
                      label: Text(
                        "Submit Form",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // Narrow screen - stacked buttons
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _checkForm,
                      icon: Icon(Icons.check_circle, color: Colors.white),
                      label: Text(
                        "Check Form",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: Icon(Icons.send, color: Colors.white),
                      label: Text(
                        "Submit Form",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }

  Widget _buildFamilyTable(
      List<Map<String, String>> list, List<String> headers) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: {
        for (int i = 0; i < headers.length; i++) i: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: headers
              .map((e) => Padding(
                    padding: EdgeInsets.all(8),
                    child:
                        Text(e, style: TextStyle(fontWeight: FontWeight.bold)),
                  ))
              .toList(),
        ),
        ...list.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> data = entry.value;
          return TableRow(
            children: headers.map((header) {
              String value =
                  header == 'Index' ? '${index + 1}' : data[header] ?? '';
              return Padding(
                padding: EdgeInsets.all(8),
                child: Text(value),
              );
            }).toList(),
          );
        })
      ],
    );
  }

  void _addFamilyRow(List<Map<String, String>> list,
      {bool isDependent = false}) {
    setState(() {
      list.add({
        'Full Name': '',
        'Age': '',
        if (isDependent) 'Reason for Dependency': '',
      });
    });
  }

  Widget _buildRequestList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text("LTC Request ${index + 1}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status: Forwarded"),
                Text(
                    "Submitted On: ${DateFormat('dd MMM yyyy').format(DateTime.now())}"),
                Text("Destination: Delhi"),
              ],
            ),
            trailing: Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }

  Widget _buildInboxList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.inbox, color: Colors.blueAccent),
            title: Text("Inbox Item ${index + 1}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("From: Head of Department"),
                Text("Subject: LTC Approval Required"),
                Text(
                    "Date: ${DateFormat('dd MMM yyyy').format(DateTime.now())}"),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }

  Widget _buildArchiveList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          color: Colors.grey[100],
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.archive, color: Colors.grey),
            title: Text("Archived LTC Request ${index + 1}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Archived On: ${DateFormat('dd MMM yyyy').format(DateTime.now())}"),
                Text("Status: Approved"),
                Text("Destination: Mumbai"),
              ],
            ),
            trailing: Icon(Icons.history, color: Colors.grey),
          ),
        );
      },
    );
  }
}
