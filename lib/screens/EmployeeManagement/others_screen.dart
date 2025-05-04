import 'package:flutter/material.dart';

class OthersScreen extends StatefulWidget {
  const OthersScreen({super.key});

  @override
  _OthersScreenState createState() => _OthersScreenState();
}

class _OthersScreenState extends State<OthersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Form controllers for the Achievements tab
  final TextEditingController _achievementDayController =
      TextEditingController();
  final TextEditingController _achievementMonthController =
      TextEditingController();
  final TextEditingController _achievementYearController =
      TextEditingController();
  final TextEditingController _achievementTypeController =
      TextEditingController();
  final TextEditingController _achievementTitleController =
      TextEditingController();

  // Form controllers for the Expert Lectures tab
  final TextEditingController _lectureTypeController = TextEditingController();
  final TextEditingController _lecturePlaceController = TextEditingController();
  final TextEditingController _lectureDateController = TextEditingController();
  final TextEditingController _lectureTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _achievementDayController.dispose();
    _achievementMonthController.dispose();
    _achievementYearController.dispose();
    _achievementTypeController.dispose();
    _achievementTitleController.dispose();
    _lectureTypeController.dispose();
    _lecturePlaceController.dispose();
    _lectureDateController.dispose();
    _lectureTitleController.dispose();
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
            'Others',
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
                  final tabTitles = ['Achievements', 'Expert Lectures'];

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
            _buildAchievementsTab(),
            _buildExpertLecturesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hintText,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add an Achievement',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(label: 'Day*', controller: _achievementDayController),
          _buildTextField(
              label: 'Month*', controller: _achievementMonthController),
          _buildTextField(
              label: 'Year*', controller: _achievementYearController),
          _buildTextField(
              label: 'Achievement Type*',
              controller: _achievementTypeController),
          _buildTextField(
              label: 'Title*', controller: _achievementTitleController),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save achievement details
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
          const Text(
            'Projects Report',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No Achievements Recorded Yet',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertLecturesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add an Expert Lecture',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
              label: 'Presentation Type*', controller: _lectureTypeController),
          _buildTextField(label: 'Place*', controller: _lecturePlaceController),
          _buildTextField(label: 'Date*', controller: _lectureDateController),
          _buildTextField(label: 'Title*', controller: _lectureTitleController),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save expert lecture details
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
          const Text(
            'Projects Report',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No Lectures/Talks Recorded Yet',
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
