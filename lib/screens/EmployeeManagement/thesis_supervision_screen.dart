import 'package:flutter/material.dart';

class ThesisSupervisionScreen extends StatefulWidget {
  const ThesisSupervisionScreen({super.key});

  @override
  _ThesisSupervisionScreenState createState() =>
      _ThesisSupervisionScreenState();
}

class _ThesisSupervisionScreenState extends State<ThesisSupervisionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Form controllers for PG Thesis
  final TextEditingController _pgNameController = TextEditingController();
  final TextEditingController _pgRollNumberController = TextEditingController();
  final TextEditingController _pgMonthController = TextEditingController();
  final TextEditingController _pgYearController = TextEditingController();
  final TextEditingController _pgTitleController = TextEditingController();
  final TextEditingController _pgSupervisorController =
      TextEditingController();

  // Form controllers for PhD Thesis
  final TextEditingController _phdNameController = TextEditingController();
  final TextEditingController _phdRollNumberController =
      TextEditingController();
  final TextEditingController _phdMonthController = TextEditingController();
  final TextEditingController _phdYearController = TextEditingController();
  final TextEditingController _phdTitleController = TextEditingController();
  final TextEditingController _phdSupervisorController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pgNameController.dispose();
    _pgRollNumberController.dispose();
    _pgMonthController.dispose();
    _pgYearController.dispose();
    _pgTitleController.dispose();
    _pgSupervisorController.dispose();
    _phdNameController.dispose();
    _phdRollNumberController.dispose();
    _phdMonthController.dispose();
    _phdYearController.dispose();
    _phdTitleController.dispose();
    _phdSupervisorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Thesis Supervision',
            style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(2, (index) {
                  final isSelected = _tabController.index == index;
                  final tabTitles = ['PG Thesis', 'PhD Thesis'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
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
            _buildPGThesisTab(),
            _buildPhDThesisTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildPGThesisTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add a PG Thesis',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(label: 'Name*', controller: _pgNameController),
          _buildTextField(
              label: 'Roll Number*', controller: _pgRollNumberController),
          _buildTextField(label: 'Month*', controller: _pgMonthController),
          _buildTextField(label: 'Year*', controller: _pgYearController),
          _buildTextField(label: 'Title*', controller: _pgTitleController),
          _buildTextField(
              label: 'Supervisor*', controller: _pgSupervisorController),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save PG Thesis details
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: const Text(
                  'No Thesis Found',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhDThesisTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add a PhD Thesis',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(label: 'Name*', controller: _phdNameController),
          _buildTextField(
              label: 'Roll Number*', controller: _phdRollNumberController),
          _buildTextField(label: 'Month*', controller: _phdMonthController),
          _buildTextField(label: 'Year*', controller: _phdYearController),
          _buildTextField(label: 'Title*', controller: _phdTitleController),
          _buildTextField(
              label: 'Supervisor*', controller: _phdSupervisorController),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save PhD Thesis details
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: const Text(
                  'No Thesis Found',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
