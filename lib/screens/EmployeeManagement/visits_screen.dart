import 'package:flutter/material.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({Key? key}) : super(key: key);

  @override
  _VisitsScreenState createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            'Visits',
            style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(2, (index) {
                  final isSelected = _tabController.index == index;
                  final tabTitles = ['Foreign Visits', 'Indian Visits'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                    child: Container(
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
            _buildForeignVisitsTab(),
            _buildIndianVisitsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildForeignVisitsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a Foreign Visit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          _buildTextField(label: 'Country*'),
          _buildTextField(label: 'Place*'),
          _buildTextField(label: 'From'),
          _buildTextField(label: 'To'),
          _buildTextField(label: 'Purpose*'),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save foreign visit details
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndianVisitsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add an Indian Visit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          _buildTextField(label: 'State*'),
          _buildTextField(label: 'City*'),
          _buildTextField(label: 'From'),
          _buildTextField(label: 'To'),
          _buildTextField(label: 'Purpose*'),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save Indian visit details
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hintText,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 13),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}
