import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';

class CatalogueConvenorPage extends StatefulWidget {
  const CatalogueConvenorPage({super.key});

  @override
  State<CatalogueConvenorPage> createState() => _CatalogueConvenorPageState();
}

class _CatalogueConvenorPageState extends State<CatalogueConvenorPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _selectedScholarship;
  final List<String> _scholarships = [
    'Director’s Gold Medal',
    'MCM Scholarship',
    'Academic Excellence Award',
    'Sports Scholarship',
  ];
  int _selectedTabIndex = 0; // 0: Catalogue, 1: Members, 2: Previous Winners

  // Add a map to store editable content for each scholarship
  final Map<String, String> _scholarshipDetails = {
    'Director’s Gold Medal': '• A holder of any other scholarship from another source is not eligible unless it’s renewed.\n'
        '• The Convener, SPACS will invite applications each academic year from all years except first year.\n'
        '• Students must apply using a prescribed form available in the document, on the Institute’s website, or from the Academic Section.\n'
        '• Refer to sections 4.1, 3.1, 4.2, Section 2.2, 3.1.3.2, and 3.1.3.3 for detailed policy and eligibility criteria.',
    'MCM Scholarship': 'Eligibility details for MCM Scholarship.',
    'Academic Excellence Award': 'Eligibility details for Academic Excellence Award.',
    'Sports Scholarship': 'Eligibility details for Sports Scholarship.',
  };

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Catalogue (Convenor)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.blue),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ],
        ),
        drawer: Sidebar(
          onItemSelected: (index) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Navigating to item $index'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
        body: Column(
          children: [
            const SizedBox(height: 16), // Margin below the app bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  _buildTabButton(
                    index: 0,
                    label: 'Catalogue',
                    icon: Icons.list,
                  ),
                  _buildTabButton(
                    index: 1,
                    label: 'Members',
                    icon: Icons.group,
                  ),
                  _buildTabButton(
                    index: 2,
                    label: 'Previous Winners',
                    icon: Icons.emoji_events,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4), // Space below the tabs
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildCatalogueContent()
                  : _selectedTabIndex == 1
                      ? _buildMembersContent()
                      : _buildPreviousWinnersContent(),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildTabButton(
      {required int index, required String label, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {
          if (_selectedTabIndex != index) {
            setState(() {
              _selectedTabIndex = index;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedTabIndex == index ? Colors.blue : Colors.blue.shade50,
          foregroundColor:
              _selectedTabIndex == index ? Colors.white : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _selectedTabIndex == index ? Colors.white : Colors.blue,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: _selectedTabIndex == index ? Colors.white : Colors.blue,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatalogueContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search Section
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Scholarship/Award',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: _selectedScholarship,
                    items: _scholarships
                        .map((scholarship) => DropdownMenuItem(
                              value: scholarship,
                              child: Text(scholarship),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedScholarship = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedScholarship == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a scholarship'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                  child: const Text('Search'),
                ),
              ],
            ),
          ),

          // Display content based on selected scholarship
          const SizedBox(height: 24),
          if (_selectedScholarship == null)
            const Center(
              child: Text(
                'Please select a scholarship to view details.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          else if (_selectedScholarship == 'Director’s Gold Medal')
            _buildDirectorsGoldMedalCard()
          else
            _buildSimpleCard(_selectedScholarship!),
        ],
      ),
    );
  }

  Widget _buildDirectorsGoldMedalCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Director’s Gold Medal:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _showEditDialog('Director’s Gold Medal');
                  },
                ),
              ],
            ),
            const Divider(thickness: 1, height: 20),
            const Text(
              'Eligibility Criteria:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _scholarshipDetails['Director’s Gold Medal']!,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('More details coming soon!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                ),
                child: const Text('Learn More'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(String scholarshipName) {
    final TextEditingController _controller = TextEditingController(
      text: _scholarshipDetails[scholarshipName],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $scholarshipName'),
          content: TextField(
            controller: _controller,
            maxLines: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Edit eligibility criteria here...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _scholarshipDetails[scholarshipName] = _controller.text;
                });
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Details updated successfully!'),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSimpleCard(String scholarshipName) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  scholarshipName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _showEditDialog(scholarshipName);
                  },
                ),
              ],
            ),
            const Divider(thickness: 1, height: 20),
            Text(
              _scholarshipDetails[scholarshipName]!,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersContent() {
    final members = [
      {'name': 'SPACS Convener', 'phone': '123-456-7890', 'email': 'convener@spacs.com'},
      {'name': 'SPACS Assistant', 'phone': '987-654-3210', 'email': 'assistant@spacs.com'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.blue.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member['name']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Calling ${member['phone']}')),
                              );
                            },
                            icon: const Icon(Icons.phone, size: 18),
                            label: const Text('Call'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade50,
                              foregroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Emailing ${member['email']}')),
                              );
                            },
                            icon: const Icon(Icons.email, size: 18),
                            label: const Text('Email'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade50,
                              foregroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreviousWinnersContent() {
    String? _selectedProgramme;
    String? _selectedYear;
    String? _selectedScholarship;
    bool _showWinnerDetails = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormField(
                label: 'Programme:',
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Select',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'B.Tech', child: Text('B.Tech')),
                    DropdownMenuItem(value: 'M.Tech', child: Text('M.Tech')),
                    DropdownMenuItem(value: 'Ph.D.', child: Text('Ph.D.')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedProgramme = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'Academic Year:',
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Select',
                  ),
                  items: const [
                    DropdownMenuItem(value: '2022-2023', child: Text('2022-2023')),
                    DropdownMenuItem(value: '2023-2024', child: Text('2023-2024')),
                    DropdownMenuItem(value: '2024-2025', child: Text('2024-2025')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedYear = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'Scholarships/Awards:',
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Select',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Director’s Gold Medal', child: Text('Director’s Gold Medal')),
                    DropdownMenuItem(value: 'MCM Scholarship', child: Text('MCM Scholarship')),
                    DropdownMenuItem(value: 'Academic Excellence Award', child: Text('Academic Excellence Award')),
                    DropdownMenuItem(value: 'Sports Scholarship', child: Text('Sports Scholarship')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedScholarship = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedProgramme == 'B.Tech' &&
                        _selectedYear == '2022-2023' &&
                        _selectedScholarship == 'Director’s Gold Medal') {
                      setState(() {
                        _showWinnerDetails = true;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No winner found for the selected criteria'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ),
              const SizedBox(height: 24),
              if (_showWinnerDetails)
                _buildWinnerCard(
                  name: 'Aman Raj',
                  programme: 'B.Tech',
                  year: '2022-2023',
                  scholarship: 'Director’s Gold Medal',
                  description:
                      'Aman Raj has demonstrated exceptional academic performance and leadership skills, making him a deserving recipient of the Director’s Gold Medal.',
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWinnerCard({
    required String name,
    required String programme,
    required String year,
    required String scholarship,
    required String description,
  }) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Decorative background
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('lib/screens/SPACS/aman.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$programme | $year',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Badge for the award
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), // Adjusted padding
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16), // Adjusted border radius
                        ),
                        child: const Text(
                          'Winner',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14, // Slightly increased font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    scholarship,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // "View More" button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('More details coming soon!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8), // Reduced padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18), // Slightly smaller border radius
                        ),
                      ),
                      child: const Text(
                        'View More',
                        style: TextStyle(fontSize: 16), // Reduced font size
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}