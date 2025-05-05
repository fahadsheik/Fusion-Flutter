import 'package:flutter/material.dart';

class RSPCDeptHeadView extends StatefulWidget {
  const RSPCDeptHeadView({Key? key}) : super(key: key);

  @override
  _RSPCDeptHeadViewState createState() => _RSPCDeptHeadViewState();
}

class _RSPCDeptHeadViewState extends State<RSPCDeptHeadView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentView = 'dashboard';
  final TextEditingController _projectIdController = TextEditingController();
  String? _selectedRequestId;
  Map<String, String> _selectedRequestDetails = {};
  String? _selectedFundRequestId;
  Map<String, String> _selectedFundRequestDetails = {};

  @override
  void dispose() {
    _projectIdController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_currentView != 'dashboard') {
      setState(() => _currentView = 'dashboard');
      return false;
    }
    // Don't allow going back from dashboard
    return false;
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: const Icon(Icons.emoji_objects, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              const Text(
                'Dept Head',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ExpansionTile(
            leading: const Icon(Icons.work),
            title: const Text('Manage Projects'),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 72),
                title: const Text('View Projects'),
                onTap: () => setState(() => _currentView = 'view_project'),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.people),
            title: const Text('Manage Staff'),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 72),
                title: const Text('Forward Approve Staff Request'),
                onTap: () => setState(() => _currentView = 'forward_staff_appointment_request'),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Manage Funds'),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 72),
                title: const Text('Forward Fund Request'),
                onTap: () => setState(() => _currentView = 'forward_fund_request'),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.description),
            title: const Text('Rules & Regulations'),
            children: const [],
          ),
        ],
      ),
    );
  }

  Widget _buildViewProject() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'dashboard'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Back to Dashboard',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'View Project',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _projectIdController,
            decoration: InputDecoration(
              labelText: 'Project ID',
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_projectIdController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Fetching project details...'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a Project ID'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForwardFundRequest() {
    if (_currentView == 'fund_request_details') {
      return _buildFundRequestDetailsPage();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'dashboard'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Back to Dashboard',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Forward Fund Request',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.blue),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Dept')),
                  DataColumn(label: Text('Created By')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: [
                  _buildFundRequestRow('8', 'req_1', 'req by dimw', 'CSE', 'XYZ'),
                  _buildFundRequestRow('9', 'req_2', 'req by dimw', 'CSE', 'ABC'),
                  _buildFundRequestRow('10', 'req_3', 'req by dimw', 'ME', 'PQR'),
                  _buildFundRequestRow('11', 'req_4', 'req by dimw', 'ECE', 'UVW'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildFundRequestRow(String id, String name, String description, String dept, String createdBy) {
    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(name)),
        DataCell(Text(description)),
        DataCell(Text(dept)),
        DataCell(Text(createdBy)),
        DataCell(
          ElevatedButton(
            onPressed: () {
              _selectedFundRequestId = id;
              _selectedFundRequestDetails = {
                'name': name,
                'description': description,
                'dept': dept,
                'createdBy': createdBy,
              };
              setState(() => _currentView = 'fund_request_details');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              minimumSize: const Size(60, 36),
            ),
            child: const Text('View File', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildFundRequestDetailsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'forward_fund_request'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Back to List',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Forward Fund Request',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Request Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Request ID:',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(_selectedFundRequestId ?? ''),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Created By:',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(_selectedFundRequestDetails['createdBy'] ?? ''),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'File Tracking Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Sent by:', 'ABC'),
                _buildInfoRow('Sent Date & Time:', '2025-02-18T23:55:28.727475'),
                _buildInfoRow('Received by:', 'XYZ'),
                _buildInfoRow('Dept:', 'CSE'),
                _buildInfoRow('Remarks:', 'N/A'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() => _currentView = 'forward_fund_request');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.green.shade50,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Approve'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {
                  setState(() => _currentView = 'forward_fund_request');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red.shade50,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Forward'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForwardStaffAppointmentRequest() {
    if (_currentView == 'staff_appointment_details') {
      return _buildStaffRequestDetailsPage();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'dashboard'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Back to Dashboard',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Forward Staff Appointment Request',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.blue),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Designation')),
                  DataColumn(label: Text('Dept')),
                  DataColumn(label: Text('Created By')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: [
                  _buildStaffRequestRow('8', 'req_1', 'PhD by', 'CSE', 'XYZ'),
                  _buildStaffRequestRow('9', 'req_2', 'req by', 'CSE', 'ABC'),
                  _buildStaffRequestRow('10', 'req_3', 'req by', 'ME', 'PQR'),
                  _buildStaffRequestRow('11', 'req_4', 'req by', 'ECE', 'UVW'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildStaffRequestRow(String id, String name, String designation, String dept, String createdBy) {
    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(name)),
        DataCell(Text(designation)),
        DataCell(Text(dept)),
        DataCell(Text(createdBy)),
        DataCell(
          ElevatedButton(
            onPressed: () {
              _selectedRequestId = id;
              _selectedRequestDetails = {
                'name': name,
                'designation': designation,
                'dept': dept,
                'createdBy': createdBy,
              };
              setState(() => _currentView = 'staff_appointment_details');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              minimumSize: const Size(60, 36),
            ),
            child: const Text('View', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildStaffRequestDetailsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'forward_staff_appointment_request'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Back to List',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Forward Staff Appointment Request',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Request Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Request ID:',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(_selectedRequestId ?? ''),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Created By:',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(_selectedRequestDetails['createdBy'] ?? ''),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Staff Info',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(
              color: Colors.black12,
            ),
            children: const [
              TableRow(
                decoration: BoxDecoration(
                  color: Color(0xFFE0F7F5),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Name :',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('XYZ Kumar'),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Color(0xFFE0F7F5),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'DEPARTMENT :',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('B.Tech. Computer science'),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Color(0xFFE0F7F5),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Batch :',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('2020'),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Color(0xFFE0F7F5),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'CURRENT CGPA :',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('7.5'),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Color(0xFFE0F7F5),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Degree :',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('PhD'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() => _currentView = 'forward_staff_appointment_request');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.green.shade50,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Approve'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {
                  setState(() => _currentView = 'forward_staff_appointment_request');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red.shade50,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Forward'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (_currentView) {
      case 'dashboard':
        return _buildDashboard();
      case 'view_project':
        return _buildViewProject();
      case 'forward_fund_request':
      case 'fund_request_details':
        return _buildForwardFundRequest();
      case 'forward_staff_appointment_request':
      case 'staff_appointment_details':
        return _buildForwardStaffAppointmentRequest();
      default:
        return _buildDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              _buildHeader(),
              _buildTitleBar(),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: Colors.blue,
                child: Row(
                  children: const [
                    Text(
                      'RSPC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ExpansionTile(
                        leading: const Icon(Icons.work),
                        title: const Text('Manage Projects'),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('View Projects'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'view_project');
                            },
                          ),
                        ],
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.people),
                        title: const Text('Manage Staff'),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('Forward Approve Staff Request'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'forward_staff_appointment_request');
                            },
                          ),
                        ],
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.attach_money),
                        title: const Text('Manage Funds'),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('Forward Fund Request'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'forward_fund_request');
                            },
                          ),
                        ],
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.description),
                        title: const Text('Rules & Regulations'),
                        children: const [],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: _buildCurrentView(),
      ),
    );
  }
} 