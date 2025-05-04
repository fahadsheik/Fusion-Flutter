import 'package:flutter/material.dart';

class PublicationScreen extends StatefulWidget {
  const PublicationScreen({super.key});

  @override
  _PublicationScreenState createState() => _PublicationScreenState();
}

class _PublicationScreenState extends State<PublicationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _conferenceDetailsController =
      TextEditingController();

  // Form controllers for the Journal tab
  final TextEditingController _journalTitleController = TextEditingController();
  final TextEditingController _journalAuthorsController =
      TextEditingController();
  final TextEditingController _journalDateController = TextEditingController();

  // Form controllers for the Book tab
  final TextEditingController _bookTitleController = TextEditingController();
  final TextEditingController _bookAuthorsController = TextEditingController();
  final TextEditingController _bookPublisherController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _conferenceDetailsController.dispose();
    _journalTitleController.dispose();
    _journalAuthorsController.dispose();
    _journalDateController.dispose();
    _bookTitleController.dispose();
    _bookAuthorsController.dispose();
    _bookPublisherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Publication',
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
                children: List.generate(3, (index) {
                  final isSelected = _tabController.index == index;
                  final tabTitles = ['Journal', 'Conference', 'Book'];

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
            _buildJournalTab(),
            _buildConferenceTab(),
            _buildBookTab(),
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

  Widget _buildJournalTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a Journal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          _buildTextField(label: 'Author*'),
          _buildTextField(label: 'Co-Author(s)*'),
          _buildTextField(label: 'Journal Name*'),
          _buildTextField(label: 'Journal File'),
          _buildTextField(label: 'Year*'),
          _buildTextField(label: 'Title*'),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save journal publication details
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

  Widget _buildConferenceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a Conference',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          _buildTextField(label: 'Author*'),
          _buildTextField(label: 'Co-Author(s)*'),
          _buildTextField(label: 'Conference Name*'),
          _buildTextField(label: 'Conference File'),
          _buildTextField(label: 'Title*'),
          SizedBox(height: 16),
          ExpansionTile(
            title: Text(
              'Optional Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            children: [
              _buildTextField(label: 'Venue/Host Institute'),
              _buildTextField(label: 'Date of Submission (DOS)'),
              _buildTextField(label: 'Date of Acceptance (DOA)'),
              _buildTextField(label: 'Date of Publication (DOP)'),
              _buildTextField(label: 'Page Number'),
              _buildTextField(label: 'Status'),
              _buildTextField(label: 'Conference Date(s)'),
              _buildTextField(label: 'ISBN Number'),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save conference publication details
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'Not Recorded Found Yet',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a BookBook Chapter',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          _buildTextField(label: 'Publish Type'),
          _buildTextField(label: 'Author*'),
          _buildTextField(label: 'Publisher*'),
          _buildTextField(label: 'Publishing Year*'),
          _buildTextField(label: 'Title*'),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Save book publication details
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'No Book Recorded Yet',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConferenceDetailsScreen extends StatelessWidget {
  final String details;

  const ConferenceDetailsScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conference Details',
          style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Conference Publication Details',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Optional Details:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      details.isNotEmpty ? details : 'No details provided.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
