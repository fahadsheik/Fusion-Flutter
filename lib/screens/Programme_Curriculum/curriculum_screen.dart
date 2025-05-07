import 'package:flutter/material.dart';
import '../../utils/bottom_bar.dart';
import 'curriculum_detail_screen.dart';

class CurriculumScreen extends StatefulWidget {
  const CurriculumScreen({super.key});

  @override
  State<CurriculumScreen> createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _semestersController = TextEditingController();

  late List<Map<String, dynamic>> allCurriculums;
  late List<Map<String, dynamic>> filteredCurriculums;

  @override
  void initState() {
    super.initState();
    _initializeCurriculumData();
    filteredCurriculums = List.from(allCurriculums);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _versionController.dispose();
    _batchController.dispose();
    _semestersController.dispose();
    super.dispose();
  }

  void _filterCurriculums() {
    final nameQuery = _nameController.text.toLowerCase();
    final versionQuery = _versionController.text.toLowerCase();
    final batchQuery = _batchController.text.toLowerCase();
    final semestersQuery = _semestersController.text.toLowerCase();

    setState(() {
      filteredCurriculums = allCurriculums.where((curriculum) {
        final nameMatch =
            curriculum['name'].toString().toLowerCase().contains(nameQuery);
        final versionMatch = curriculum['version']
            .toString()
            .toLowerCase()
            .contains(versionQuery);
        final batchMatch =
            curriculum['batch'].toString().toLowerCase().contains(batchQuery);
        final semestersMatch = curriculum['semesters']
            .toString()
            .toLowerCase()
            .contains(semestersQuery);
        return nameMatch && versionMatch && batchMatch && semestersMatch;
      }).toList();
    });
  }

  void _initializeCurriculumData() {
    allCurriculums = [
      {
        'name': 'ECE UG Curriculum',
        'version': '1.0',
        'batch':
            'B.Tech ECE 2016, B.Tech ECE 2017, B.Tech ECE 2018, B.Tech ECE 2019, B.Tech ECE 2020, B.Tech ECE 2021, Phd ECE 2022, B.Tech ECE 2022',
        'semesters': 8
      },
      {
        'name': 'ME UG Curriculum',
        'version': '1.0',
        'batch':
            'B.Tech ME 2016, B.Tech ME 2017, B.Tech ME 2018, B.Tech ME 2019, B.Tech ME 2020, B.Tech ME 2021, B.Tech ME 2022',
        'semesters': 8
      },
      {
        'name': 'Design UG Curriculum',
        'version': '1.0',
        'batch':
            'B.Des Des. 2018, B.Des Des. 2019, B.Des Des. 2020, B.Des Des. 2021, B.Des Des. 2022',
        'semesters': 8
      },
      {
        'name': 'CSE UG Curriculum',
        'version': '1.0',
        'batch':
            'B.Tech CSE 2016, B.Tech CSE 2017, B.Tech CSE 2018, B.Tech CSE 2019, B.Tech CSE 2020, B.Tech CSE 2021, B.Tech CSE 2022',
        'semesters': 1
      },
      {
        'name': 'SM UG Curriculum',
        'version': '1.0',
        'batch': 'B.Tech SM 2020, B.Tech SM 2021, B.Tech SM 2022',
        'semesters': 1
      },
      {
        'name': 'CSE PG Curriculum',
        'version': '1.0',
        'batch': 'M.Tech CSE 2020, M.Tech CSE 2021',
        'semesters': 4
      },
      {
        'name': 'ECE PG Curriculum',
        'version': '1.0',
        'batch': 'M.Tech ME 2020, M.Tech ECE 2020, M.Tech ECE 2021',
        'semesters': 4
      },
      {
        'name': 'ME PG Curriculum',
        'version': '1.0',
        'batch': 'M.Tech ME 2021',
        'semesters': 4
      },
      {
        'name': 'Design PG Curriculum',
        'version': '1.0',
        'batch': 'M.Des Des. 2020, M.Des Des. 2021',
        'semesters': 4
      },
      {
        'name': 'PG Mechatronics Curriculum v1',
        'version': '1.0',
        'batch': 'M.Tech MT 2020, M.Tech MT 2021',
        'semesters': 4
      },
      {
        'name': 'M.Tech SM',
        'version': '1.0',
        'batch': 'B.Des ECE 2024',
        'semesters': 4
      },
      {
        'name': 'ME Undergraduate Curriculum',
        'version': '2.0',
        'batch': 'M.Tech ECE 2024',
        'semesters': 8
      },
      {
        'name': 'CSE Phd Curriculum',
        'version': '1.0',
        'batch':
            'Phd CSE 2016, Phd CSE 2017, Phd CSE 2018, Phd CSE 2019, Phd CSE 2020, Phd CSE 2021, Phd CSE 2022',
        'semesters': 4
      },
      {
        'name': 'ECE Phd Curriculum',
        'version': '1.0',
        'batch':
            'Phd ECE 2016, Phd ECE 2017, Phd ECE 2018, Phd ECE 2019, Phd ECE 2020, Phd ECE 2021',
        'semesters': 4
      },
      {
        'name': 'ME Phd Curriculum',
        'version': '1.0',
        'batch':
            'Phd ME 2016, Phd ME 2017, Phd ME 2018, Phd ME 2019, Phd ME 2020, Phd ME 2021, Phd ME 2022',
        'semesters': 4
      },
      {
        'name': 'PhD Natural Sciences (Maths) Curriculum',
        'version': '1.0',
        'batch':
            'Phd Maths 2016, Phd Maths 2017, Phd Maths 2018, Phd Maths 2019, Phd Maths 2020, Phd Maths 2021',
        'semesters': 4
      },
      {
        'name': 'PhD in Natural Sciences (Physics)',
        'version': '1.0',
        'batch':
            'Phd Physics 2016, Phd Physics 2017, Phd Physics 2019, Phd Physics 2020, Phd Physics 2021',
        'semesters': 4
      },
      {
        'name': 'PhD in Humanities (English)',
        'version': '1.0',
        'batch':
            'Phd English 2016, Phd English 2017, Phd Physics 2018, Phd English 2019, Phd English 2020, Phd English 2021',
        'semesters': 4
      },
      {
        'name': 'PhD in Design',
        'version': '1.0',
        'batch':
            'Phd Des. 2016, Phd Des. 2017, Phd Des. 2018, Phd Des. 2019, Phd Des. 2020, Phd Des. 2021',
        'semesters': 4
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5), // Light gray background to match screenshot
      appBar: AppBar(
        title: const Text(
          'Curriculum',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top button - exactly as in the screenshot
              ElevatedButton(
                onPressed: () {
                  // Action for Curriculums button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF2196F3), // Bright blue matching screenshot
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(4.0), // Less rounded corners
                  ),
                ),
                child: const Text('Curriculums'),
              ),

              // Divider
              const Divider(height: 32.0),

              // Name field
              const Text(
                'Name:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _nameController,
                onChanged: (_) => _filterCurriculums(),
                decoration: InputDecoration(
                  hintText: 'Search by Name',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Version field
              const Text(
                'Version:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _versionController,
                onChanged: (_) => _filterCurriculums(),
                decoration: InputDecoration(
                  hintText: 'Search by Version',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Batch field
              const Text(
                'Batch:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _batchController,
                onChanged: (_) => _filterCurriculums(),
                decoration: InputDecoration(
                  hintText: 'Search by Batch',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // No. of Semesters field
              const Text(
                'No. of Semesters:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _semestersController,
                onChanged: (_) => _filterCurriculums(),
                decoration: InputDecoration(
                  hintText: 'Search by No. of Semesters',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Table
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                height: 400, // Fixed height for vertical scrolling
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width > 800
                        ? MediaQuery.of(context).size.width
                        : 800, // Minimum width
                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.vertical, // Enable vertical scrolling
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder(
                          horizontalInside:
                              BorderSide(color: Colors.grey.shade300),
                        ),
                        columnWidths: const {
                          0: FixedColumnWidth(250), // Name - with fixed width
                          1: FixedColumnWidth(
                              100), // Version - with fixed width
                          2: FixedColumnWidth(350), // Batch - with fixed width
                          3: FixedColumnWidth(
                              120), // Semesters - with fixed width
                        },
                        children: [
                          // Table header
                          TableRow(
                            decoration: const BoxDecoration(
                              color: Color(
                                  0xFFE3F2FD), // Light blue background for header
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Version',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Batch',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'No. of Semesters',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Table rows
                          ...filteredCurriculums.asMap().entries.map((entry) {
                            final index = entry.key;
                            final curriculum = entry.value;
                            return TableRow(
                              decoration: BoxDecoration(
                                color: index.isEven
                                    ? const Color(0xFFE3F2FD)
                                    : Colors.white, // Alternate row colors
                              ),
                              children: [
                                // Name column (clickable)
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CurriculumDetailScreen(
                                            curriculumName:
                                                curriculum['name'].toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      alignment: Alignment.centerLeft,
                                      foregroundColor: Colors.blue,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      curriculum['name'].toString(),
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                                // Version column
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    curriculum['version'].toString(),
                                  ),
                                ),
                                // Batch column
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    curriculum['batch'].toString(),
                                  ),
                                ),
                                // Semesters column
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    curriculum['semesters'].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
