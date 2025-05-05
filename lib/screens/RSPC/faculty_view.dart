import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../models/fund_request.dart';
import '../../services/navigation_service.dart';

class InventoryItem {
  final String id;
  final String name;
  final int quantity;
  final String lastUsed;
  final String description;

  InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.lastUsed,
    required this.description,
  });
}

class RSPCFacultyView extends StatefulWidget {
  const RSPCFacultyView({Key? key}) : super(key: key);

  @override
  _RSPCFacultyViewState createState() => _RSPCFacultyViewState();
}

class _RSPCFacultyViewState extends State<RSPCFacultyView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentView = 'dashboard';
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _noOfStaffController = TextEditingController();
  InventoryItem? _selectedInventoryItem;
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _projectIdController = TextEditingController();

  // Sample inventory data
  final List<InventoryItem> _inventoryItems = [
    InventoryItem(
      id: '001',
      name: 'XYZ',
      quantity: 2020,
      lastUsed: 'NA',
      description: 'Lorem ipsum',
    ),
    // Add more sample items as needed
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
                'Faculty Name',
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

  Widget _buildClosureReport() {
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
              'Closure Report',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
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
                    'Upload your file:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implement file picker functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('File picker will be implemented here'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Choose a file'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Remarks',
                      filled: true,
                      fillColor: Color(0xFFE0E0E0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    maxLines: 3,
                    controller: _remarksController,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_remarksController.text.isNotEmpty) {
                          // Here you would typically upload the file and remarks
                          print('Submitting closure report with remarks: ${_remarksController.text}');
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Closure report submitted successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          
                          // Clear the form
                          _remarksController.clear();
                          
                          // Return to dashboard
                          setState(() => _currentView = 'dashboard');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please add remarks before submitting'),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewStaff() {
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
              'View Staff Info',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
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
                _buildInfoRow('Name:', 'XYZ Kumar'),
                const SizedBox(height: 12),
                _buildInfoRow('DEPARTMENT:', 'B.Tech Computer science'),
                const SizedBox(height: 12),
                _buildInfoRow('Batch:', '2020'),
                const SizedBox(height: 12),
                _buildInfoRow('CURRENT CGPA:', '7.5'),
                const SizedBox(height: 12),
                _buildInfoRow('Degree:', 'PhD'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestStaff() {
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
              'Request Staff Form',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _degreeController,
            decoration: InputDecoration(
              labelText: 'Degree',
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noOfStaffController,
            decoration: InputDecoration(
              labelText: 'No. of Staff',
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle staff request submission
                if (_degreeController.text.isNotEmpty && 
                    _noOfStaffController.text.isNotEmpty) {
                  // Process the request
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Staff request submitted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  _degreeController.clear();
                  _noOfStaffController.clear();
                  setState(() => _currentView = 'dashboard');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields'),
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

  Widget _buildViewInventory() {
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
              const Center(
                child: Text(
                  'View Inventory',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Header Row
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: const [
                    SizedBox(width: 40, child: Text('ID')),
                    SizedBox(width: 16),
                    SizedBox(width: 80, child: Text('Name')),
                    SizedBox(width: 16),
                    Expanded(child: Text('Description')),
                    SizedBox(width: 16),
                    SizedBox(width: 60, child: Text('Dept')),
                    SizedBox(width: 16),
                    SizedBox(width: 60, child: Text('Qty Left')),
                    SizedBox(width: 16),
                    SizedBox(width: 80, child: Text('Actions')),
                  ],
                ),
              ),
              // List of items
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _inventoryItems.length,
                itemBuilder: (context, index) {
                  final item = _inventoryItems[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 40, child: Text('${index + 8}')),
                        const SizedBox(width: 16),
                        SizedBox(width: 80, child: Text('req_${index + 1}')),
                        const SizedBox(width: 16),
                        Expanded(child: Text('req by dmw')),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 60, 
                          child: Text(index == 2 ? 'ME' : index == 3 ? 'ECE' : 'CSE')
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 60,
                          child: Text(index == 1 ? '2' : index == 2 ? '3' : index == 3 ? 'NA' : '12'),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 80,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedInventoryItem = item;
                                _currentView = 'inventory_details';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              minimumSize: const Size(60, 30),
                            ),
                            child: const Text(
                              'View',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryDetails() {
    if (_selectedInventoryItem == null) {
      return const Center(child: Text('No item selected'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => setState(() => _currentView = 'view_inventory'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Back to View Inventory',
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
              'Inventory Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
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
                _buildDetailRow('Name of Item:', _selectedInventoryItem!.name),
                _buildDetailRow('Item ID:', _selectedInventoryItem!.id),
                _buildDetailRow('Quantity Left:', _selectedInventoryItem!.quantity.toString()),
                _buildDetailRow('Last Used:', _selectedInventoryItem!.lastUsed),
                _buildDetailRow('Description:', _selectedInventoryItem!.description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestRequirement() {
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
              'Request Requirement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
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
                    'Upload your file:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle file selection
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Choose a file'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _remarksController,
                    decoration: InputDecoration(
                      labelText: 'Remarks',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_remarksController.text.isNotEmpty) {
                          // Process the request
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Request submitted successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          _remarksController.clear();
                          setState(() => _currentView = 'dashboard');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please add remarks'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: const Text(
              'RSPC',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
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
                      title: const Text('Submit Closure Report'),
                      onTap: () => setState(() => _currentView = 'closure_report'),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Manage Staff'),
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 72),
                      title: const Text('View Staff'),
                      onTap: () => setState(() => _currentView = 'view_staff'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 72),
                      title: const Text('Request Staff'),
                      onTap: () => setState(() => _currentView = 'request_staff'),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.inventory),
                  title: const Text('Manage Inventory'),
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 72),
                      title: const Text('View Inventory'),
                      onTap: () => setState(() => _currentView = 'view_inventory'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 72),
                      title: const Text('Request Requirement'),
                      onTap: () => setState(() => _currentView = 'request_inventory'),
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
      case 'closure_report':
        return _buildClosureReport();
      case 'view_staff':
        return _buildViewStaff();
      case 'request_staff':
        return _buildRequestStaff();
      case 'view_inventory':
        return _buildViewInventory();
      case 'inventory_details':
        return _buildInventoryDetails();
      case 'request_inventory':
        return _buildRequestRequirement();
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
                color: Colors.white,
                child: Row(
                  children: const [
                    Text(
                      'RSPC',
                      style: TextStyle(
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
                            title: const Text('Submit Closure Report'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'closure_report');
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
                            title: const Text('View Staff'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'view_staff');
                            },
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('Request Staff'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'request_staff');
                            },
                          ),
                        ],
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.inventory),
                        title: const Text('Manage Inventory'),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('View Inventory'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'view_inventory');
                            },
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 72),
                            title: const Text('Request Requirement'),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() => _currentView = 'request_inventory');
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