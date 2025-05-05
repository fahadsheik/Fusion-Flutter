import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/bottom_bar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/sidebar.dart'; // Import the sidebar
import 'ltc_page.dart';
import 'CpdaAdvanceFormScreen.dart';
import 'CpdaClaim.dart';

class LeaveFormScreen extends StatefulWidget {
  @override
  _LeaveFormScreenState createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends State<LeaveFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _pfNumberController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _academicRespController = TextEditingController();
  final TextEditingController _adminRespController = TextEditingController();
  final TextEditingController _receiverUsernameController =
      TextEditingController();
  final TextEditingController _receiverDesignationController =
      TextEditingController();

  DateTime? _applicationDate;
  DateTime? _leaveStartDate;
  DateTime? _leaveEndDate;

  int selectedTab = 0;

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

  bool _validateForm() {
    return _nameController.text.isNotEmpty &&
        _designationController.text.isNotEmpty &&
        _departmentController.text.isNotEmpty &&
        _pfNumberController.text.isNotEmpty &&
        _applicationDate != null &&
        _leaveStartDate != null &&
        _leaveEndDate != null &&
        _purposeController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _academicRespController.text.isNotEmpty &&
        _adminRespController.text.isNotEmpty &&
        _receiverUsernameController.text.isNotEmpty &&
        _receiverDesignationController.text.isNotEmpty;
  }

  void _handleCheck() {
    if (_validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('All fields are filled and valid!'),
            backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please fill all required fields'),
            backgroundColor: Colors.red),
      );
    }
  }

  void _handleSubmit() {
    if (_validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Leave form submitted successfully!'),
            backgroundColor: Colors.blue),
      );
      // TODO: Replace with actual submit logic (e.g., sending data to backend)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please check form fields before submitting.'),
            backgroundColor: Colors.red),
      );
    }
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

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: TextButton(
        onPressed: () => setState(() => selectedTab = index),
        style: TextButton.styleFrom(
          backgroundColor:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12, // Adjust font size for smaller screens
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Leave Management',
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 400;
                return isSmallScreen
                    ? Column(
                        children: [
                          Row(
                            children: [
                              _buildTabButton("Leave Form", 0),
                              _buildTabButton("Leave Requests", 1),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildTabButton("Leave Inbox", 2),
                              _buildTabButton("Leave Archive", 3),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          _buildTabButton("Leave Form", 0),
                          _buildTabButton("Leave Requests", 1),
                          _buildTabButton("Leave Inbox", 2),
                          _buildTabButton("Leave Archive", 3),
                        ],
                      );
              },
            ),
          ),
          Expanded(child: _buildTabView()),
        ],
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 1),
    );
  }

  Widget _buildTabView() {
    switch (selectedTab) {
      case 1:
        return LeaveRequests();
      case 2:
        return LeaveInbox();
      case 3:
        return LeaveArchive();
      default:
        return _buildLeaveForm();
    }
  }

  Widget _buildLeaveForm() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTabletOrLarger = screenWidth > 600;

    // Calculate responsive paddings and spacings
    final horizontalPadding = screenWidth * (isTabletOrLarger ? 0.05 : 0.04);
    final fieldSpacing = screenHeight * 0.015;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display form title with icon that matches the image you shared
          Container(
            margin: EdgeInsets.only(bottom: fieldSpacing * 1.5),
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.blue.shade200, width: 1)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.file_download_outlined, color: Colors.blue),
                ),
                SizedBox(width: 12),
                Text(
                  "LEAVE Application Form",
                  style: TextStyle(
                    fontSize: isTabletOrLarger ? 22 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
          ),

          // Responsive form layout
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Tablet and larger: two-column layout
                return Column(
                  children: [
                    // First row - Name and Designation
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildFormField(
                            label: "Enter your name",
                            child: TextField(
                              controller: _nameController,
                              decoration: getInputDecoration(
                                  "Enter your name", Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            label: "Designation",
                            child: TextField(
                              controller: _designationController,
                              decoration: getInputDecoration(
                                  "Designation", Icons.badge),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),

                    // Second row - Department and PF number
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildFormField(
                            label: "Department",
                            child: TextField(
                              controller: _departmentController,
                              decoration: getInputDecoration(
                                  "Department", Icons.apartment),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            label: "Enter your PF number",
                            child: TextField(
                              controller: _pfNumberController,
                              decoration: getInputDecoration(
                                  "Enter your PF number", Icons.numbers),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),

                    // Third row - Application Date
                    _buildFormField(
                      label: "Date of application",
                      child: GestureDetector(
                        onTap: () => _selectDate(context, _applicationDate,
                            (date) => _applicationDate = date),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 55,
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: Colors.blue.shade700),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _formatDate(_applicationDate),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.grey.shade700),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),

                    // Fourth row - Leave start and end dates
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildFormField(
                            label: "Leave start date",
                            child: GestureDetector(
                              onTap: () => _selectDate(context, _leaveStartDate,
                                  (date) => _leaveStartDate = date),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 55,
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: Colors.blue.shade700),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _formatDate(_leaveStartDate),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        color: Colors.grey.shade700),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            label: "Leave end date",
                            child: GestureDetector(
                              onTap: () => _selectDate(context, _leaveEndDate,
                                  (date) => _leaveEndDate = date),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 55,
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: Colors.blue.shade700),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _formatDate(_leaveEndDate),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        color: Colors.grey.shade700),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),

                    // Rest of fields - single column for longer text inputs
                    _buildFormField(
                      label: "Purpose",
                      child: TextField(
                        controller: _purposeController,
                        decoration: getInputDecoration(
                            "Purpose of leave", Icons.edit_note),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Address during leave",
                      child: TextField(
                        controller: _addressController,
                        decoration: getInputDecoration(
                            "Address during leave", Icons.location_on),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),

                    // Responsibilities row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildFormField(
                            label: "Academic responsibility",
                            child: TextField(
                              controller: _academicRespController,
                              decoration: getInputDecoration(
                                  "Academic responsibility", Icons.school),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            label: "Administrative responsibility",
                            child: TextField(
                              controller: _adminRespController,
                              decoration: getInputDecoration(
                                  "Administrative responsibility",
                                  Icons.admin_panel_settings),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),

                    // Receiver information row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildFormField(
                            label: "Receiver's username",
                            child: TextField(
                              controller: _receiverUsernameController,
                              decoration: getInputDecoration(
                                  "Receiver's username", Icons.account_circle),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            label: "Receiver's designation",
                            child: TextField(
                              controller: _receiverDesignationController,
                              decoration: getInputDecoration(
                                  "Receiver's designation", Icons.work_outline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                // Mobile: single column layout
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormField(
                      label: "Enter your name",
                      child: TextField(
                        controller: _nameController,
                        decoration:
                            getInputDecoration("Enter your name", Icons.person),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Designation",
                      child: TextField(
                        controller: _designationController,
                        decoration:
                            getInputDecoration("Designation", Icons.badge),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Department",
                      child: TextField(
                        controller: _departmentController,
                        decoration:
                            getInputDecoration("Department", Icons.apartment),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Enter your PF number",
                      child: TextField(
                        controller: _pfNumberController,
                        decoration: getInputDecoration(
                            "Enter your PF number", Icons.numbers),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Date of application",
                      child: GestureDetector(
                        onTap: () => _selectDate(context, _applicationDate,
                            (date) => _applicationDate = date),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 55,
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: Colors.blue.shade700),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _formatDate(_applicationDate),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.grey.shade700),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Leave start date",
                      child: GestureDetector(
                        onTap: () => _selectDate(context, _leaveStartDate,
                            (date) => _leaveStartDate = date),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 55,
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: Colors.blue.shade700),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _formatDate(_leaveStartDate),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.grey.shade700),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Leave end date",
                      child: GestureDetector(
                        onTap: () => _selectDate(context, _leaveEndDate,
                            (date) => _leaveEndDate = date),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 55,
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: Colors.blue.shade700),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _formatDate(_leaveEndDate),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.grey.shade700),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Purpose",
                      child: TextField(
                        controller: _purposeController,
                        decoration: getInputDecoration(
                            "Purpose of leave", Icons.edit_note),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Address during leave",
                      child: TextField(
                        controller: _addressController,
                        decoration: getInputDecoration(
                            "Address during leave", Icons.location_on),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Academic responsibility",
                      child: TextField(
                        controller: _academicRespController,
                        decoration: getInputDecoration(
                            "Academic responsibility", Icons.school),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Administrative responsibility",
                      child: TextField(
                        controller: _adminRespController,
                        decoration: getInputDecoration(
                            "Administrative responsibility",
                            Icons.admin_panel_settings),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Receiver's username",
                      child: TextField(
                        controller: _receiverUsernameController,
                        decoration: getInputDecoration(
                            "Receiver's username", Icons.account_circle),
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildFormField(
                      label: "Receiver's designation",
                      child: TextField(
                        controller: _receiverDesignationController,
                        decoration: getInputDecoration(
                            "Receiver's designation", Icons.work_outline),
                      ),
                    ),
                  ],
                );
              }
            },
          ),

          // Responsive buttons layout
          SizedBox(height: screenHeight * 0.03),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                // Wide screen - buttons side by side with more space
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _handleCheck,
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
                      onPressed: _handleSubmit,
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
                      onPressed: _handleCheck,
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
                      onPressed: _handleSubmit,
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
          // Bottom padding for scrolling
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}

class LeaveRequestTile extends StatelessWidget {
  final String title;
  final String subtitle;

  LeaveRequestTile(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(Icons.description_outlined, color: Colors.blue.shade700),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(subtitle),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            size: 16, color: Colors.grey.shade600),
      ),
    );
  }
}

class LeaveRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        LeaveRequestTile("Academic Responsibility", "8:00 AM"),
        LeaveRequestTile("Forwarded Request", "9:05 AM"),
        LeaveRequestTile("Atul Gupta", "Dec 19"),
        LeaveRequestTile("Pritee Khanna", "Nov 02"),
        LeaveRequestTile("Administrative Responsibility", "Oct 29"),
      ],
    );
  }
}

class LeaveInbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        LeaveRequestTile("Academic Responsibility", "8:00 AM"),
        LeaveRequestTile("Forwarded Request", "9:05 AM"),
        LeaveRequestTile("Atul Gupta", "Dec 19"),
        LeaveRequestTile("Pritee Khanna", "Nov 02"),
        LeaveRequestTile("Administrative Responsibility", "Oct 29"),
      ],
    );
  }
}

class LeaveArchive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        LeaveRequestTile("Academic Responsibility", "8:00 AM"),
        LeaveRequestTile("Forwarded Request", "9:05 AM"),
        LeaveRequestTile("Atul Gupta", "Dec 19"),
        LeaveRequestTile("Pritee Khanna", "Nov 02"),
        LeaveRequestTile("Administrative Responsibility", "Oct 29"),
      ],
    );
  }
}
