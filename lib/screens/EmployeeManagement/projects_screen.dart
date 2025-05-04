import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  final int initialTabIndex;

  const ProjectsScreen({super.key, this.initialTabIndex = 0});

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Form controllers for Research Projects
  final TextEditingController _piController = TextEditingController();
  final TextEditingController _coPiController = TextEditingController();
  final TextEditingController _fundingAgencyController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _submissionDateController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _finishDateController = TextEditingController();
  final TextEditingController _financialOutlayController =
      TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  // Form controllers for Patents
  final TextEditingController _patentNumberController = TextEditingController();
  final TextEditingController _patentStatusController = TextEditingController();
  final TextEditingController _earningsController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _patentTitleController = TextEditingController();

  // Form controllers for Consultancy Projects
  final TextEditingController _consultantController = TextEditingController();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _consultancyOutlayController =
      TextEditingController();
  final TextEditingController _consultancyStartDateController =
      TextEditingController();
  final TextEditingController _consultancyEndDateController =
      TextEditingController();
  final TextEditingController _consultancyTitleController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = widget.initialTabIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _piController.dispose();
    _coPiController.dispose();
    _fundingAgencyController.dispose();
    _statusController.dispose();
    _submissionDateController.dispose();
    _startDateController.dispose();
    _finishDateController.dispose();
    _financialOutlayController.dispose();
    _titleController.dispose();
    _patentNumberController.dispose();
    _patentStatusController.dispose();
    _earningsController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _patentTitleController.dispose();
    _consultantController.dispose();
    _clientController.dispose();
    _consultancyOutlayController.dispose();
    _consultancyStartDateController.dispose();
    _consultancyEndDateController.dispose();
    _consultancyTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Projects',
          style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(3, (index) {
                final isSelected = _tabController.index == index;
                final tabTitles = [
                  'Research Projects',
                  'Patents',
                  'Consultancy Projects'
                ];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _tabController.index = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.blue, width: 1.5),
                    ),
                    child: Text(
                      tabTitles[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.blue,
                        fontSize: isSmallScreen ? 13 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildResearchProjectsTab(),
          _buildPatentsTab(),
          _buildConsultancyProjectsTab(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildResearchProjectsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add a Research Project',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          SizedBox(height: 16),
          _buildTextField(
              label: 'Project Incharge (PI)*', controller: _piController),
          _buildTextField(
              label: 'Co Project Incharge (CO-PI)*',
              controller: _coPiController),
          _buildTextField(
              label: 'Funding Agency*', controller: _fundingAgencyController),
          _buildTextField(label: 'Status*', controller: _statusController),
          _buildTextField(
              label: 'Submission Date', controller: _submissionDateController),
          _buildTextField(
              label: 'Start Date', controller: _startDateController),
          _buildTextField(
              label: 'Expected Finish Date', controller: _finishDateController),
          _buildTextField(
              label: 'Financial Outlay*',
              controller: _financialOutlayController),
          _buildTextField(label: 'Title*', controller: _titleController),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save research project details
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button color to blue
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add a Patent',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          SizedBox(height: 16),
          _buildTextField(
              label: 'Patent Number*', controller: _patentNumberController),
          _buildTextField(
              label: 'Status*', controller: _patentStatusController),
          _buildTextField(
              label: 'Earnings (in Rs.)*', controller: _earningsController),
          _buildTextField(label: 'Month', controller: _monthController),
          _buildTextField(label: 'Year', controller: _yearController),
          _buildTextField(label: 'Title*', controller: _patentTitleController),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save patent details
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button color to blue
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultancyProjectsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add a Consultancy Project',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          SizedBox(height: 16),
          _buildTextField(
              label: 'Consultant*', controller: _consultantController),
          _buildTextField(label: 'Client*', controller: _clientController),
          _buildTextField(
              label: 'Financial Outlay*',
              controller: _consultancyOutlayController),
          _buildTextField(
              label: 'Start Date', controller: _consultancyStartDateController),
          _buildTextField(
              label: 'End Date', controller: _consultancyEndDateController),
          _buildTextField(
              label: 'Title*', controller: _consultancyTitleController),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save consultancy project details
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button color to blue
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ),
        ],
      ),
    );
  }
}
