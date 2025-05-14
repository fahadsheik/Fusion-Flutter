import 'package:flutter/material.dart';

class CurriculumDetailScreen extends StatelessWidget {
  final String curriculumName;

  const CurriculumDetailScreen({
    Key? key,
    required this.curriculumName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          curriculumName,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: CurriculumTableWidget(),
        ),
      ),
    );
  }
}

class CurriculumTableWidget extends StatelessWidget {
  const CurriculumTableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define semesters data
    final List<Map<String, dynamic>> semesters = [
      {
        "semester": "Semester 1",
        "credits": 19,
        "courses": [
          {"code": "", "details": "(L: 3, T: 1, C: 4)"},
          {"code": "", "details": "(L: 2, T: 1, C: 4)"},
          {"code": "", "details": "(L: 2, T: 0, C: 2)"},
          {"code": "", "details": "(L: 3, T: 0, C: 5)"},
          {"code": "", "details": "(L: 2, T: 0, C: 4)"},
        ],
      },
      {
        "semester": "Semester 2",
        "credits": 18,
        "courses": [
          {"code": "", "details": "(L: -, T: -, C: 4)"},
          {"code": "", "details": "(L: 3, T: 2, C: 4)"},
          {"code": "", "details": "(L: 2, T: 0, C: 3)"},
          {"code": "", "details": "(L: 1, T: 0, C: 2)"},
          {"code": "", "details": "(L: 10, T: 0, C: 1)"},
        ],
      },
      {
        "semester": "Semester 3",
        "credits": 23,
        "courses": [
          {"code": "", "details": "(L: 2, T: 0, C: 3)"},
          {"code": "", "details": "(L: 3, T: 0, C: 4)"},
          {"code": "", "details": "(L: 2, T: 0, C: 2)"},
          {"code": "OE1", "details": ""},
          {"code": "", "details": "(L: 0, T: 0, C: 2)"},
        ],
      },
      {
        "semester": "Semester 4",
        "credits": 22,
        "courses": [
          {"code": "", "details": "(L: 2, T: 0, C: 4)"},
          {"code": "", "details": "(L: 3, T: 0, C: 4)"},
          {"code": "", "details": "(L: 3, T: 1, C: 4)"},
          {"code": "", "details": "(L: 0, T: 0, C: 2)"},
        ],
      },
      {
        "semester": "Semester 5",
        "credits": 21,
        "courses": [
          {"code": "", "details": "(L: 1, T: 0, C: 4)"},
          {"code": "", "details": "(L: 3, T: 0, C: 3)"},
          {"code": "OE3", "details": ""},
          {"code": "", "details": "(L: 0, T: 0, C: 2)"},
        ],
      },
      {
        "semester": "Semester 6",
        "credits": 20,
        "courses": [
          {"code": "", "details": "(L: 0, T: 0, C: 2)"},
          {"code": "OE4ECE", "details": ""},
          {"code": "OE5ECE", "details": ""},
          {"code": "OE6ECE", "details": ""},
        ],
      },
      {
        "semester": "Semester 7",
        "credits": 16,
        "courses": [
          {"code": "OE07", "details": ""},
          {"code": "OE08", "details": ""},
          {"code": "OE09", "details": ""},
          {"code": "OE11", "details": ""},
          {"code": "OE10", "details": ""},
        ],
      },
      {
        "semester": "Semester 8",
        "credits": 20,
        "courses": [
          {"code": "ES7/HS5/NS6/DS3/MN2", "details": ""},
          {"code": "Prof EL7", "details": ""},
          {"code": "Prof EI 8", "details": ""},
          {"code": "Prof EI 9", "details": ""},
          {"code": "Project or Prof EI 10", "details": ""},
        ],
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ECE UG Curriculum Table',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),

          // Using Row and Column instead of Table to avoid the irregular row length error
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First column - labels
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Empty cell at top-left corner
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  ),

                  // Empty cell for top rows
                  Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  ),

                  // Course rows (use the maximum number of courses per semester)
                  for (int i = 0; i < 7; i++)
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                    ),

                  // Footer rows
                  _buildLabelContainer('Start Date'),
                  _buildLabelContainer('End Date'),
                  _buildLabelContainer('Total Credits'),
                  _buildLabelContainer('Instigated'),
                ],
              ),

              // Semester columns
              ...semesters.map((semester) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Semester header
                    Container(
                      height: 60,
                      width: 180,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: Text(
                          semester['semester'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    // Batch details
                    Container(
                      height: 40,
                      width: 180,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                    ),

                    // Course cells
                    for (int i = 0; i < 7; i++)
                      Container(
                        height: 50,
                        width: 180,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: i < (semester['courses'] as List).length
                            ? Center(
                                child: Text(
                                  (semester['courses'][i]['code'] as String)
                                          .isNotEmpty
                                      ? semester['courses'][i]['code']
                                      : semester['courses'][i]['details'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: (semester['courses'][i]['code']
                                                as String)
                                            .isNotEmpty
                                        ? Colors.black
                                        : Colors.blue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : null,
                      ),

                    // Date cells
                    _buildDataContainer('N/A'),
                    _buildDataContainer('N/A'),

                    // Credits cell
                    _buildDataContainer(semester['credits'].toString()),

                    // Instigated cell
                    Container(
                      height: 40,
                      width: 180,
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Text(
                        'Not Yet',
                        style: TextStyle(
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabelContainer(String text) {
    return Container(
      height: 40,
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildDataContainer(String text) {
    return Container(
      height: 40,
      width: 180,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
