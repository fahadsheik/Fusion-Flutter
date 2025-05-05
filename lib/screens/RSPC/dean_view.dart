import 'package:flutter/material.dart';
import '../../services/navigation_service.dart';

class StaffRequest {
  final String id;
  final String name;
  final String department;
  final String batch;
  final double cgpa;
  final String degree;

  StaffRequest({
    required this.id,
    required this.name,
    required this.department,
    required this.batch,
    required this.cgpa,
    required this.degree,
  });
}

class FundRequest {
  final String id;
  final String name;
  final String description;
  final String dept;
  final String amount;
  final String status;
  final String createdBy;
  final String sentTo;
  final String receivedBy;
  final String fileDate;

  FundRequest({
    required this.id,
    required this.name,
    required this.description,
    required this.dept,
    required this.amount,
    required this.status,
    required this.createdBy,
    required this.sentTo,
    required this.receivedBy,
    required this.fileDate,
  });
}

class RSPCDeanView extends StatefulWidget {
  const RSPCDeanView({Key? key}) : super(key: key);

  @override
  _RSPCDeanViewState createState() => _RSPCDeanViewState();
}

class _RSPCDeanViewState extends State<RSPCDeanView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentView = 'dashboard';
  final TextEditingController _projectIdController = TextEditingController();
  StaffRequest? _selectedStaffRequest;
  FundRequest? _selectedFundRequest;

  // Sample staff requests data
  final List<StaffRequest> _staffRequests = [
    StaffRequest(
      id: "SR-1",
      name: "XYZ Kumar",
      department: "B.Tech Computer science",
      batch: "2020",
      cgpa: 7.5,
      degree: "PhD",
    ),
  ];

  // Sample fund requests data
  final List<FundRequest> _fundRequests = [
    FundRequest(
      id: "FR-1",
      name: "Project A",
      description: "Research Project",
      dept: "CSE",
      amount: "50000",
      status: "Pending",
      createdBy: "ABC",
      sentTo: "XYZ",
      receivedBy: "CSE",
      fileDate: "2024-02-18T23:00:28.725Z",
    ),
  ];

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
                'Dean RSPC',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Menu'),
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
                title: const Text('Approve Staff Request'),
                onTap: () => setState(() => _currentView = 'staff_appointment_request'),
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
                  // Here you would typically make an API call to fetch project details
                  // For now, we'll show a success message and log the project ID
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

  Widget _buildStaffAppointmentRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
                'Staff Appointment Request',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _staffRequests.length,
            itemBuilder: (context, index) {
              final request = _staffRequests[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Request ${request.id}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text('Name: ${request.name}'),
                            Text('Department: ${request.department}'),
                            Text('Batch: ${request.batch}'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedStaffRequest = request;
                            _currentView = 'staff_request_details';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStaffRequestDetails() {
    if (_selectedStaffRequest == null) {
      return const Center(child: Text('No request selected'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'staff_appointment_request'),
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Name:', _selectedStaffRequest!.name),
                _buildInfoRow('DEPARTMENT:', _selectedStaffRequest!.department),
                _buildInfoRow('Batch:', _selectedStaffRequest!.batch),
                _buildInfoRow('CURRENT CGPA:', _selectedStaffRequest!.cgpa.toString()),
                _buildInfoRow('Degree:', _selectedStaffRequest!.degree),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Request approved'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  setState(() => _currentView = 'staff_appointment_request');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Approve'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Request rejected'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  setState(() => _currentView = 'staff_appointment_request');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Reject'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForwardFundRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _fundRequests.length,
            itemBuilder: (context, index) {
              final request = _fundRequests[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Request ${request.id}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text('Name: ${request.name}'),
                            Text('Department: ${request.dept}'),
                            Text('Amount: ₹${request.amount}'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedFundRequest = request;
                            _currentView = 'fund_request_details';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFundRequestDetails() {
    if (_selectedFundRequest == null) {
      return const Center(child: Text('No request selected'));
    }

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
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Request ID:', _selectedFundRequest!.id),
                  _buildInfoRow('Created By:', _selectedFundRequest!.createdBy),
                  const SizedBox(height: 16),
                  const Text(
                    'File Tracking Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Sent To:', _selectedFundRequest!.sentTo),
                  _buildInfoRow('Received By:', _selectedFundRequest!.receivedBy),
                  _buildInfoRow('Status:', _selectedFundRequest!.status),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Request approved'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() => _currentView = 'forward_fund_request');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('Approve'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Request forwarded'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                          setState(() => _currentView = 'forward_fund_request');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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

  Widget _buildCurrentView() {
    switch (_currentView) {
      case 'dashboard':
        return _buildDashboard();
      case 'view_project':
        return _buildViewProject();
      case 'staff_appointment_request':
        return _buildStaffAppointmentRequest();
      case 'staff_request_details':
        return _buildStaffRequestDetails();
      case 'forward_fund_request':
        return _buildForwardFundRequest();
      case 'fund_request_details':
        return _buildFundRequestDetails();
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
                            title: const Text('Approve Staff Request'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'staff_appointment_request');
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