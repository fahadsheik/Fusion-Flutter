import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/sidebar.dart'; // Import the sidebar

class CpdaClaimFormScreen extends StatefulWidget {
  @override
  _CpdaClaimFormScreenState createState() => _CpdaClaimFormScreenState();
}

class _CpdaClaimFormScreenState extends State<CpdaClaimFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _adjustmentAmountController = TextEditingController();
  final TextEditingController _advanceTakenController = TextEditingController();
  final TextEditingController _pfNumberController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _billCheckedController = TextEditingController();
  final TextEditingController _balanceAvailableController = TextEditingController();
  final TextEditingController _pdaRegisterPageController = TextEditingController();
  final TextEditingController _receiverUsernameController = TextEditingController();
  final TextEditingController _receiverDesignationController = TextEditingController();

  DateTime? _applicationDate;
  int selectedTab = 0;

  String _formatDate(DateTime? date) {
    if (date == null) return "dd/mm/yyyy";
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Future<void> _selectDate(BuildContext context, DateTime? initialDate, Function(DateTime) onSelected) async {
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
        _adjustmentAmountController.text.isNotEmpty &&
        _applicationDate != null &&
        _advanceTakenController.text.isNotEmpty &&
        _pfNumberController.text.isNotEmpty &&
        _purposeController.text.isNotEmpty &&
        _billCheckedController.text.isNotEmpty &&
        _balanceAvailableController.text.isNotEmpty &&
        _pdaRegisterPageController.text.isNotEmpty &&
        _receiverUsernameController.text.isNotEmpty &&
        _receiverDesignationController.text.isNotEmpty;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.blueAccent),
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
            fontSize: 12,
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
          'CPDA Claim',
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
                              _buildTabButton("CPDA Claim Form", 0),
                              _buildTabButton("Requests", 1),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildTabButton("Inbox", 2),
                              _buildTabButton("Archive", 3),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          _buildTabButton("CPDA Claim Form", 0),
                          _buildTabButton("Requests", 1),
                          _buildTabButton("Inbox", 2),
                          _buildTabButton("Archive", 3),
                        ],
                      );
              },
            ),
          ),
          Expanded(child: _buildTabView()),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    switch (selectedTab) {
      case 1:
        return CpdaClaimRequests();
      case 2:
        return CpdaClaimInbox();
      case 3:
        return CpdaClaimArchive();
      default:
        return _buildClaimForm();
    }
  }

  Widget _buildClaimForm() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTabletOrLarger = screenWidth > 600;

    final horizontalPadding = screenWidth * (isTabletOrLarger ? 0.05 : 0.04);
    final fieldSpacing = screenHeight * 0.015;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: screenHeight * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: fieldSpacing * 1.5),
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.blue.shade200, width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.account_balance_wallet,
                      color: Colors.blue),
                ),
                SizedBox(width: 12),
                Text(
                  "CPDA Claim Form",
                  style: TextStyle(
                    fontSize: isTabletOrLarger ? 22 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            "Enter your name",
                            _nameController,
                            Icons.person,
                            screenWidth,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            "Designation",
                            _designationController,
                            Icons.badge,
                            screenWidth,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            "Adjustment/Reimbursement submitted for Rs.",
                            _adjustmentAmountController,
                            Icons.currency_rupee,
                            screenWidth,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildDateField(
                            "Date of application",
                            _applicationDate,
                            (date) => _applicationDate = date,
                            screenWidth,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            "Advance Taken",
                            _advanceTakenController,
                            Icons.money,
                            screenWidth,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            "PF Number",
                            _pfNumberController,
                            Icons.numbers,
                            screenWidth,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Purpose",
                      _purposeController,
                      Icons.edit_note,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    Text(
                      "Internal Audit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Bill checked in Audit for Rs.",
                      _billCheckedController,
                      Icons.check_circle_outline,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    Text(
                      "Estt. Section",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            "Balance available as on date",
                            _balanceAvailableController,
                            Icons.account_balance_wallet,
                            screenWidth,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            "Adjustment/Reimbursement amount entered in PDA Register page no.",
                            _pdaRegisterPageController,
                            Icons.library_books,
                            screenWidth,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            "Receiver's username",
                            _receiverUsernameController,
                            Icons.person,
                            screenWidth,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            "Receiver's designation",
                            _receiverDesignationController,
                            Icons.badge,
                            screenWidth,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      "Enter your name",
                      _nameController,
                      Icons.person,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Designation",
                      _designationController,
                      Icons.badge,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Adjustment/Reimbursement submitted for Rs.",
                      _adjustmentAmountController,
                      Icons.currency_rupee,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildDateField(
                      "Date of application",
                      _applicationDate,
                      (date) => _applicationDate = date,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Advance Taken",
                      _advanceTakenController,
                      Icons.money,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "PF Number",
                      _pfNumberController,
                      Icons.numbers,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Purpose",
                      _purposeController,
                      Icons.edit_note,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    Text(
                      "Internal Audit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Bill checked in Audit for Rs.",
                      _billCheckedController,
                      Icons.check_circle_outline,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    Text(
                      "Estt. Section",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Balance available as on date",
                      _balanceAvailableController,
                      Icons.account_balance_wallet,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Adjustment/Reimbursement amount entered in PDA Register page no.",
                      _pdaRegisterPageController,
                      Icons.library_books,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Receiver's username",
                      _receiverUsernameController,
                      Icons.person,
                      screenWidth,
                    ),
                    SizedBox(height: fieldSpacing),
                    _buildTextField(
                      "Receiver's designation",
                      _receiverDesignationController,
                      Icons.badge,
                      screenWidth,
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(height: screenHeight * 0.03),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_validateForm()) {
                          _showMessage("All fields are correctly filled.");
                        } else {
                          _showMessage(
                              "Please fill all the fields before checking.");
                        }
                      },
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
                      onPressed: () {
                        if (_validateForm()) {
                          _showMessage("Form submitted successfully.");
                        } else {
                          _showMessage(
                              "Please complete all fields before submitting.");
                        }
                      },
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_validateForm()) {
                          _showMessage("All fields are correctly filled.");
                        } else {
                          _showMessage(
                              "Please fill all the fields before checking.");
                        }
                      },
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
                      onPressed: () {
                        if (_validateForm()) {
                          _showMessage("Form submitted successfully.");
                        } else {
                          _showMessage(
                              "Please complete all fields before submitting.");
                        }
                      },
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

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, double screenWidth, {bool isNumber = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(icon, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, Function(DateTime) onDateSelected, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () => _selectDate(context, date, onDateSelected),
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
                      _formatDate(date),
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                  Icon(Icons.calendar_view_month, color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CpdaClaimRequestTile extends StatelessWidget {
  final String title;
  final String subtitle;

  CpdaClaimRequestTile(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.mail, color: Colors.blueAccent),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class CpdaClaimRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        CpdaClaimRequestTile("CPDA Claim Request 1", "9:30 AM"),
        CpdaClaimRequestTile("CPDA Claim Request 2", "11:15 AM"),
      ],
    );
  }
}

class CpdaClaimInbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        CpdaClaimRequestTile("Inbox CPDA 1", "Yesterday"),
        CpdaClaimRequestTile("Inbox CPDA 2", "2 days ago"),
      ],
    );
  }
}

class CpdaClaimArchive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        CpdaClaimRequestTile("Archive CPDA 1", "Last week"),
        CpdaClaimRequestTile("Archive CPDA 2", "Last month"),
      ],
    );
  }
}
