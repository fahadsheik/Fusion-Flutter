import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../models/fund_request.dart';
import '../../models/staff_appointment.dart';
import '../../services/navigation_service.dart';
import '../../services/rspc_service.dart';

class RSPCAdminView extends StatefulWidget {
  const RSPCAdminView({Key? key}) : super(key: key);

  @override
  _RSPCAdminViewState createState() => _RSPCAdminViewState();
}

class _RSPCAdminViewState extends State<RSPCAdminView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _projectIdController = TextEditingController();
  final _projectTypeController = TextEditingController();
  final _sponsoredAgencyController = TextEditingController();
  final _titleController = TextEditingController();
  final _financialOutlayController = TextEditingController();
  final _startDateController = TextEditingController();
  DateTime? _selectedDate;
  String _currentView = 'dashboard';
  int _currentIndex = 0;

  @override
  void dispose() {
    _projectIdController.dispose();
    _projectTypeController.dispose();
    _sponsoredAgencyController.dispose();
    _titleController.dispose();
    _financialOutlayController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    RSPCNavigationService.goBack(context);
    return false;
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
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
                child: const Icon(Icons.person, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              const Text(
                'Admin Name',
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

  Widget _buildAddProject() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const Center(
            child: Text(
              'Add Project',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _projectIdController,
            decoration: const InputDecoration(
              labelText: 'Project Investigator ID',
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: TextEditingController(),
            decoration: const InputDecoration(
              labelText: 'Co PI IDs',
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _projectTypeController,
            decoration: const InputDecoration(
              labelText: 'Project Type',
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _sponsoredAgencyController,
            decoration: const InputDecoration(
              labelText: 'Sponsored Agency',
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: TextEditingController(),
            decoration: const InputDecoration(
              labelText: 'Years',
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _startDateController,
            decoration: InputDecoration(
              labelText: 'Start Date',
              filled: true,
              fillColor: const Color(0xFFE0E0E0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                      _startDateController.text = picked.toString().split(' ')[0];
                    });
                  }
                },
              ),
            ),
            readOnly: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _financialOutlayController,
            decoration: const InputDecoration(
              labelText: 'Financial Outlay',
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: _submitProject,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewProject() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const Center(
            child: Text(
              'View Project',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Project ID',
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            controller: _projectIdController,
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_projectIdController.text.isNotEmpty) {
                  // Here you would typically make an API call to fetch project details
                  print('Fetching details for project ID: ${_projectIdController.text}');
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Fetching details for project: ${_projectIdController.text}'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  
                  // TODO: Add your API call here to fetch project details
                  // Example:
                  // fetchProjectDetails(_projectIdController.text).then((projectDetails) {
                  //   // Handle the project details
                  //   setState(() {
                  //     // Update state with project details
                  //   });
                  // });
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const Center(
            child: Text(
              'Forward Fund Request',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Dept')),
                  DataColumn(label: Text('Created By')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(Text('8')),
                      const DataCell(Text('req_1')),
                      const DataCell(Text('req by dmw')),
                      const DataCell(Text('CSE')),
                      const DataCell(Text('XYZ')),
                      DataCell(
                        ElevatedButton(
                          onPressed: () => setState(() => _currentView = 'forward_fund_request_detail'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('View File'),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text('9')),
                      const DataCell(Text('req_2')),
                      const DataCell(Text('req by dmw')),
                      const DataCell(Text('CSE')),
                      const DataCell(Text('ABC')),
                      DataCell(
                        ElevatedButton(
                          onPressed: () => setState(() => _currentView = 'forward_fund_request_detail'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('View File'),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text('10')),
                      const DataCell(Text('req_3')),
                      const DataCell(Text('req by dmw')),
                      const DataCell(Text('ME')),
                      const DataCell(Text('PQR')),
                      DataCell(
                        ElevatedButton(
                          onPressed: () => setState(() => _currentView = 'forward_fund_request_detail'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('View File'),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text('11')),
                      const DataCell(Text('req_4')),
                      const DataCell(Text('req by dmw')),
                      const DataCell(Text('ECE')),
                      const DataCell(Text('UVW')),
                      DataCell(
                        ElevatedButton(
                          onPressed: () => setState(() => _currentView = 'forward_fund_request_detail'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('View File'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForwardFundRequestDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
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
                Text(
                  'Back to List',
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
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Request Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Request ID:', 'req_1'),
                  _buildInfoRow('Created By:', 'ABC'),
                  const SizedBox(height: 24),
                  const Text(
                    'File Tracking Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Sent by:', 'ABC'),
                  _buildInfoRow('Sent Date & Time:', '2025-02-18T23:55:28.72425'),
                  _buildInfoRow('Received by:', 'XYZ'),
                  _buildInfoRow('Dept:', 'CSE'),
                  _buildInfoRow('Remarks:', 'N/A'),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle approve
                          setState(() => _currentView = 'forward_fund_request');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('Approve'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle forward
                          setState(() => _currentView = 'forward_fund_request');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('Forward'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffAppointmentRequest() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const Center(
            child: Text(
              'Staff Appointment Request',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('S.No')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Dept')),
                DataColumn(label: Text('CGPA')),
                DataColumn(label: Text('Action')),
              ],
              rows: List<DataRow>.generate(
                4,
                (index) => DataRow(
                  cells: [
                    DataCell(Text('${index + 1}')),
                    const DataCell(Text('XYZ Kumar')),
                    const DataCell(Text('CSE')),
                    const DataCell(Text('7.5')),
                    DataCell(
                      TextButton(
                        onPressed: () => setState(() {
                          _currentView = 'staff_appointment_detail';
                        }),
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffAppointmentDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'staff_appointment'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Back to List',
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
            'Staff Appointment Request',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Request Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Name:', 'XYZ Kumar'),
                  _buildInfoRow('Department:', 'B.Tech Computer science'),
                  _buildInfoRow('Batch:', '2020'),
                  _buildInfoRow('Current CGPA:', '7.5'),
                  _buildInfoRow('Degree:', 'PhD'),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle approve
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Approve'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle reject
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Reject'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _submitProject() {
    // TODO: Implement project submission
    final project = Project(
      projectId: _projectIdController.text,
      projectType: _projectTypeController.text,
      sponsoredAgency: _sponsoredAgencyController.text,
      title: _titleController.text,
      startDate: _selectedDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      financialOutlay: double.tryParse(_financialOutlayController.text) ?? 0.0,
    );
    
    // Clear form
    _projectIdController.clear();
    _projectTypeController.clear();
    _sponsoredAgencyController.clear();
    _titleController.clear();
    _startDateController.clear();
    _financialOutlayController.clear();
    _selectedDate = null;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project added successfully')),
    );

    setState(() {
      _currentView = 'dashboard';
    });
  }

  Widget _buildManageStipendList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'dashboard'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Back to List',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Manage Stipend',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Dept')),
                DataColumn(label: Text('CGPA')),
                DataColumn(label: Text('Action')),
              ],
              rows: List<DataRow>.generate(
                4,
                (index) => DataRow(
                  cells: [
                    DataCell(Text('${index + 1}')),
                    const DataCell(Text('XYZ Kumar')),
                    const DataCell(Text('CSE')),
                    const DataCell(Text('7.5')),
                    DataCell(
                      TextButton(
                        onPressed: () => setState(() {
                          _currentView = 'manage_stipend_detail';
                        }),
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageStipendDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'manage_stipend'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Back to List',
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
            'Manage Stipend',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Staff Info',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Name:', 'XYZ Kumar'),
                  _buildInfoRow('Department:', 'B.Tech Computer science'),
                  _buildInfoRow('Batch:', '2020'),
                  _buildInfoRow('Current CGPA:', '7.5'),
                  _buildInfoRow('Degree:', 'PhD'),
                  const SizedBox(height: 24),
                  const Text(
                    'Stipend',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Amount',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Stipend in words',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle submit
                        setState(() => _currentView = 'manage_stipend');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
    );
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
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('Add Projects'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'add_project');
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
                            title: const Text('Manage Stipend'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'manage_stipend');
                            },
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('Approve Staff Request'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'staff_appointment');
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
              ListTile(
                contentPadding: const EdgeInsets.only(left: 72),
                title: const Text('Add Projects'),
                onTap: () => setState(() => _currentView = 'add_project'),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.people),
            title: const Text('Manage Staff'),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 72),
                title: const Text('Manage Stipend'),
                onTap: () => setState(() => _currentView = 'manage_stipend'),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 72),
                title: const Text('Approve Staff Request'),
                onTap: () => setState(() => _currentView = 'staff_appointment'),
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
        ],
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (_currentView) {
      case 'dashboard':
        return _buildDashboard();
      case 'add_project':
        return _buildAddProject();
      case 'view_project':
        return _buildViewProject();
      case 'forward_fund_request':
        return _buildForwardFundRequest();
      case 'forward_fund_request_detail':
        return _buildForwardFundRequestDetail();
      case 'staff_appointment':
        return _buildStaffAppointmentRequest();
      case 'staff_appointment_detail':
        return _buildStaffAppointmentDetail();
      case 'manage_stipend':
        return _buildManageStipendList();
      case 'manage_stipend_detail':
        return _buildManageStipendDetail();
      default:
        return _buildDashboard();
    }
  }
} 