import 'package:flutter/material.dart';
import '../../utils/bottom_bar.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/home.dart';
import 'curriculum_pages.dart'; // Replace all the individual imports with this single import

class BatchesScreen extends StatefulWidget {
  const BatchesScreen({super.key});

  @override
  State<BatchesScreen> createState() => _BatchesScreenState();
}

class _BatchesScreenState extends State<BatchesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showActiveBatches =
      true; // To toggle between active and finished batches

  // Controllers for the filters
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _disciplineController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _curriculumController = TextEditingController();

  bool _isLoading = false; // Add the missing _isLoading field

  Widget _buildFormField({required String label, required Widget child}) {
    // Add the missing _buildFormField method
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        child,
      ],
    );
  }

  // Data for active batches
  final List<Map<String, dynamic>> _activeBatchesData = [
    {
      'name': 'Phd',
      'discipline': 'ME',
      'year': '2016',
      'curriculum': 'ME Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'CSE',
      'year': '2016',
      'curriculum': 'CSE Phd Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ME',
      'year': '2016',
      'curriculum': 'ME UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ECE',
      'year': '2016',
      'curriculum': 'ECE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Maths',
      'year': '2016',
      'curriculum': 'PhD Natural Sciences (Maths) Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Des.',
      'year': '2016',
      'curriculum': 'PhD in Design'
    },
    {
      'name': 'Phd',
      'discipline': 'English',
      'year': '2016',
      'curriculum': 'PhD in Humanities (English)'
    },
    {
      'name': 'Phd',
      'discipline': 'Physics',
      'year': '2016',
      'curriculum': 'PhD in Natural Sciences (Physics)'
    },
    {
      'name': 'B.Tech',
      'discipline': 'CSE',
      'year': '2016',
      'curriculum': 'CSE UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Des.',
      'year': '2017',
      'curriculum': 'PhD in Design'
    },
    {
      'name': 'Phd',
      'discipline': 'Physics',
      'year': '2017',
      'curriculum': 'PhD in Natural Sciences (Physics)'
    },
    {
      'name': 'Phd',
      'discipline': 'ME',
      'year': '2017',
      'curriculum': 'ME Phd Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'CSE',
      'year': '2017',
      'curriculum': 'CSE UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ME',
      'year': '2017',
      'curriculum': 'ME UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ECE',
      'year': '2017',
      'curriculum': 'ECE UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Maths',
      'year': '2017',
      'curriculum': 'PhD Natural Sciences (Maths) Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'English',
      'year': '2017',
      'curriculum': 'PhD in Humanities (English)'
    },
    {
      'name': 'Phd',
      'discipline': 'CSE',
      'year': '2017',
      'curriculum': 'CSE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ECE',
      'year': '2017',
      'curriculum': 'ECE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Maths',
      'year': '2018',
      'curriculum': 'PhD Natural Sciences (Maths) Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ME',
      'year': '2018',
      'curriculum': 'ME UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'CSE',
      'year': '2018',
      'curriculum': 'CSE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ECE',
      'year': '2018',
      'curriculum': 'ECE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Des.',
      'year': '2018',
      'curriculum': 'PhD in Design'
    },
    {
      'name': 'B.Tech',
      'discipline': 'CSE',
      'year': '2018',
      'curriculum': 'CSE UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ECE',
      'year': '2018',
      'curriculum': 'ECE UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Physics',
      'year': '2018',
      'curriculum': 'PhD in Humanities (English)'
    },
    {
      'name': 'B.Des',
      'discipline': 'Des.',
      'year': '2018',
      'curriculum': 'Design UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ME',
      'year': '2018',
      'curriculum': 'ME Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'English',
      'year': '2019',
      'curriculum': 'PhD in Humanities (English)'
    },
    {
      'name': 'Phd',
      'discipline': 'Des.',
      'year': '2019',
      'curriculum': 'PhD in Design'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ECE',
      'year': '2019',
      'curriculum': 'ECE UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ME',
      'year': '2019',
      'curriculum': 'ME Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'CSE',
      'year': '2019',
      'curriculum': 'CSE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ECE',
      'year': '2019',
      'curriculum': 'ECE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Physics',
      'year': '2019',
      'curriculum': 'PhD in Natural Sciences (Physics)'
    },
    {
      'name': 'B.Tech',
      'discipline': 'CSE',
      'year': '2019',
      'curriculum': 'CSE UG Curriculum'
    },
    {
      'name': 'B.Des',
      'discipline': 'Des.',
      'year': '2019',
      'curriculum': 'Design UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ME',
      'year': '2019',
      'curriculum': 'ME UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Maths',
      'year': '2019',
      'curriculum': 'PhD Natural Sciences (Maths) Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Des.',
      'year': '2020',
      'curriculum': 'PhD in Design'
    },
    {
      'name': 'B.Tech',
      'discipline': 'CSE',
      'year': '2020',
      'curriculum': 'CSE UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'SM',
      'year': '2020',
      'curriculum': 'SM UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ME',
      'year': '2020',
      'curriculum': 'ME UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ECE',
      'year': '2020',
      'curriculum': 'ECE UG Curriculum'
    },
    {
      'name': 'B.Des',
      'discipline': 'Des.',
      'year': '2020',
      'curriculum': 'Design UG Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'CSE',
      'year': '2020',
      'curriculum': 'CSE PG Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'ME',
      'year': '2020',
      'curriculum': 'ECE PG Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'ECE',
      'year': '2020',
      'curriculum': 'ECE PG Curriculum'
    },
    {
      'name': 'M.Des',
      'discipline': 'Des.',
      'year': '2020',
      'curriculum': 'Design PG Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'MT',
      'year': '2020',
      'curriculum': 'PG Mechatronics Curriculum v1'
    },
    {
      'name': 'Phd',
      'discipline': 'ME',
      'year': '2020',
      'curriculum': 'ME Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ECE',
      'year': '2020',
      'curriculum': 'ECE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'CSE',
      'year': '2020',
      'curriculum': 'CSE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Physics',
      'year': '2020',
      'curriculum': 'PhD in Natural Sciences (Physics)'
    },
    {
      'name': 'Phd',
      'discipline': 'English',
      'year': '2020',
      'curriculum': 'PhD in Humanities (English)'
    },
    {
      'name': 'Phd',
      'discipline': 'Maths',
      'year': '2020',
      'curriculum': 'PhD Natural Sciences (Maths) Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ECE',
      'year': '2021',
      'curriculum': 'ECE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Des.',
      'year': '2021',
      'curriculum': 'PhD in Design'
    },
    {
      'name': 'B.Des',
      'discipline': 'Des.',
      'year': '2021',
      'curriculum': 'Design UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'SM',
      'year': '2021',
      'curriculum': 'SM UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ECE',
      'year': '2021',
      'curriculum': 'ECE UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ME',
      'year': '2021',
      'curriculum': 'ME UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'CSE',
      'year': '2021',
      'curriculum': 'CSE UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'Maths',
      'year': '2021',
      'curriculum': 'PhD Natural Sciences (Maths) Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'CSE',
      'year': '2021',
      'curriculum': 'CSE Phd Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ME',
      'year': '2021',
      'curriculum': 'ME Phd Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'MT',
      'year': '2021',
      'curriculum': 'PG Mechatronics Curriculum v1'
    },
    {
      'name': 'Phd',
      'discipline': 'English',
      'year': '2021',
      'curriculum': 'PhD in Humanities (English)'
    },
    {
      'name': 'Phd',
      'discipline': 'Physics',
      'year': '2021',
      'curriculum': 'PhD in Natural Sciences (Physics)'
    },
    {
      'name': 'M.Des',
      'discipline': 'Des.',
      'year': '2021',
      'curriculum': 'Design PG Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'ME',
      'year': '2021',
      'curriculum': 'ME PG Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'ECE',
      'year': '2021',
      'curriculum': 'ECE PG Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'CSE',
      'year': '2021',
      'curriculum': 'CSE PG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ECE',
      'year': '2022',
      'curriculum': 'ECE UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'ME',
      'year': '2022',
      'curriculum': 'ME Phd Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'CSE',
      'year': '2022',
      'curriculum': 'CSE UG Curriculum'
    },
    {
      'name': 'Phd',
      'discipline': 'CSE',
      'year': '2022',
      'curriculum': 'CSE Phd Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ECE',
      'year': '2022',
      'curriculum': 'ECE UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'SM',
      'year': '2022',
      'curriculum': 'SM UG Curriculum'
    },
    {
      'name': 'B.Des',
      'discipline': 'Des.',
      'year': '2022',
      'curriculum': 'Design UG Curriculum'
    },
    {
      'name': 'B.Tech',
      'discipline': 'ME',
      'year': '2022',
      'curriculum': 'ME UG Curriculum'
    },
  ];

  // Data for finished batches
  final List<Map<String, dynamic>> _finishedBatchesData = [
    {
      'name': 'B.Tech',
      'discipline': 'ECE',
      'year': '2016',
      'curriculum': 'ECE UG Curriculum'
    },
    {
      'name': 'M.Tech',
      'discipline': 'ECE',
      'year': '2024',
      'curriculum': 'ME Undergraduate Curriculum'
    },
    {
      'name': 'B.Des',
      'discipline': 'ECE',
      'year': '2024',
      'curriculum': 'M.Tech SM'
    },
  ];

  // Filtered data
  late List<Map<String, dynamic>> _filteredData;

  @override
  void initState() {
    super.initState();
    _filteredData = List.from(_activeBatchesData);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _disciplineController.dispose();
    _yearController.dispose();
    _curriculumController.dispose();
    super.dispose();
  }

  // Apply filters to data
  void _filterData() {
    final String nameFilter = _nameController.text.toLowerCase();
    final String disciplineFilter = _disciplineController.text.toLowerCase();
    final String yearFilter = _yearController.text.toLowerCase();
    final String curriculumFilter = _curriculumController.text.toLowerCase();

    final sourceData =
        _showActiveBatches ? _activeBatchesData : _finishedBatchesData;

    setState(() {
      _filteredData = sourceData.where((batch) {
        final nameMatch = nameFilter.isEmpty ||
            batch['name'].toString().toLowerCase().contains(nameFilter);
        final disciplineMatch = disciplineFilter.isEmpty ||
            batch['discipline']
                .toString()
                .toLowerCase()
                .contains(disciplineFilter);
        final yearMatch = yearFilter.isEmpty ||
            batch['year'].toString().toLowerCase().contains(yearFilter);
        final curriculumMatch = curriculumFilter.isEmpty ||
            batch['curriculum']
                .toString()
                .toLowerCase()
                .contains(curriculumFilter);

        return nameMatch && disciplineMatch && yearMatch && curriculumMatch;
      }).toList();
    });
  }

  // Reset filters
  void _resetFilters() {
    setState(() {
      _nameController.clear();
      _disciplineController.clear();
      _yearController.clear();
      _curriculumController.clear();
      _filteredData = _showActiveBatches
          ? List.from(_activeBatchesData)
          : List.from(_finishedBatchesData);
    });
  }

  // Handle tab switching
  void _switchTab(bool showActiveBatches) {
    setState(() {
      _showActiveBatches = showActiveBatches;
      _resetFilters();
    });
  }

  // Handle curriculum link click
  void _handleCurriculumClick(String curriculum) {
    if (curriculum == 'ME Phd Curriculum') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MePhdCurriculumPage(),
        ),
      );
    } else if (curriculum == 'CSE Phd Curriculum') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CsePhdCurriculumPage(),
        ),
      );
    } else if (curriculum == 'ME UG Curriculum') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MeUgCurriculumPage(),
        ),
      );
    } else if (curriculum == 'ECE Phd Curriculum') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EcePhdCurriculumPage(),
        ),
      );
    } else if (curriculum == 'PhD Natural Sciences (Maths) Curriculum') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MathsPhdCurriculumPage(),
        ),
      );
    } else {
      // For other curricula, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigating to $curriculum details'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      edgeWidthFactor: 1.0,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Batches',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.blue.shade700,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        drawer: Sidebar(onItemSelected: (index) {}),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormField(
                      label: 'Batch Name',
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Search by Batch Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: (value) => _filterData(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Discipline',
                      child: TextField(
                        controller: _disciplineController,
                        decoration: InputDecoration(
                          hintText: 'Search by Discipline',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: (value) => _filterData(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Year',
                      child: TextField(
                        controller: _yearController,
                        decoration: InputDecoration(
                          hintText: 'Search by Year',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: (value) => _filterData(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      label: 'Curriculum',
                      child: TextField(
                        controller: _curriculumController,
                        decoration: InputDecoration(
                          hintText: 'Search by Curriculum',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: (value) => _filterData(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _filterData,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Search Batches'),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text(
                          'Batch Results',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Exporting batches to Excel'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Export'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) => Colors.grey.shade100,
                          ),
                          columns: const [
                            DataColumn(
                                label: Text('Batch Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Discipline',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Year',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Curriculum',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: _filteredData
                              .map(
                                (batch) => DataRow(
                                  cells: [
                                    DataCell(Text(batch['name'] as String)),
                                    DataCell(
                                        Text(batch['discipline'] as String)),
                                    DataCell(Text(batch['year'] as String)),
                                    DataCell(
                                      InkWell(
                                        child: Text(
                                          batch['curriculum'] as String,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        onTap: () => _handleCurriculumClick(
                                          batch['curriculum'] as String,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
