import 'package:flutter/material.dart';
import '../../services/navigation_service.dart';

class FundRequest {
  final String id;
  final String name;
  final String description;
  final String dept;
  final String amount;
  final String status;

  FundRequest({
    required this.id,
    required this.name,
    required this.description,
    required this.dept,
    required this.amount,
    required this.status,
  });
}

class RSPCDirectorView extends StatefulWidget {
  const RSPCDirectorView({Key? key}) : super(key: key);

  @override
  _RSPCDirectorViewState createState() => _RSPCDirectorViewState();
}

class _RSPCDirectorViewState extends State<RSPCDirectorView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentView = 'dashboard';
  final TextEditingController _projectIdController = TextEditingController();
  FundRequest? _selectedRequest;

  // Sample fund requests data
  final List<FundRequest> _fundRequests = [
    FundRequest(
      id: "FR-1",
      name: "Project A",
      description: "Research Project",
      dept: "CSE",
      amount: "50000",
      status: "Pending",
    ),
    // Add more sample requests as needed
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
                'Director',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
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
            leading: const Icon(Icons.attach_money),
            title: const Text('Manage Funds'),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 72),
                title: const Text('Approve Fund Request'),
                onTap: () => setState(() => _currentView = 'approve_fund_request'),
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
                // Handle project view
                if (_projectIdController.text.isNotEmpty) {
                  // Process the request
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApproveFundRequest() {
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
                'Approve Fund Request',
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
                            _selectedRequest = request;
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
    if (_selectedRequest == null) {
      return const Center(child: Text('No request selected'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'approve_fund_request'),
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
            'Approve Fund Request',
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
                  _buildInfoRow('Request ID:', _selectedRequest!.id),
                  _buildInfoRow('Created By:', 'XYZ'),
                  const SizedBox(height: 16),
                  const Text(
                    'File Tracking Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Sent To:', 'ABC'),
                  _buildInfoRow('Received By:', 'XYZ'),
                  _buildInfoRow('Status:', 'NA'),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle approve
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Request approved'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() => _currentView = 'approve_fund_request');
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
                          // Handle reject
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Request rejected'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() => _currentView = 'approve_fund_request');
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
            width: 100,
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
      case 'approve_fund_request':
        return _buildApproveFundRequest();
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
                        leading: const Icon(Icons.attach_money),
                        title: const Text('Manage Funds'),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('Approve Fund Request'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'approve_fund_request');
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