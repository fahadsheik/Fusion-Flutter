import 'package:flutter/material.dart';
import '../../utils/bottom_bar.dart';
import 'programme_details_screen.dart'; // Import ProgrammeDetailsScreen

class DisciplineScreen extends StatefulWidget {
  const DisciplineScreen({super.key});

  @override
  State<DisciplineScreen> createState() => _DisciplineScreenState();
}

class _DisciplineScreenState extends State<DisciplineScreen> {
  final TextEditingController _disciplineController = TextEditingController();
  final TextEditingController _programmeController = TextEditingController();

  late List<Map<String, dynamic>> allDisciplines;
  late List<Map<String, dynamic>> filteredDisciplines;

  bool _isLoading = false; // Add loading indicator
  bool _showResults = false; // Track if results should be displayed

  @override
  void initState() {
    super.initState();
    _initializeDisciplineData();
    filteredDisciplines = List.from(allDisciplines);
  }

  @override
  void dispose() {
    _disciplineController.dispose();
    _programmeController.dispose();
    super.dispose();
  }

  void _filterDisciplines() {
    final disciplineQuery = _disciplineController.text.toLowerCase();
    final programmeQuery = _programmeController.text.toLowerCase();

    setState(() {
      filteredDisciplines = allDisciplines.where((discipline) {
        final disciplineMatch = discipline['name']
            .toString()
            .toLowerCase()
            .contains(disciplineQuery);

        if (programmeQuery.isEmpty) {
          return disciplineMatch;
        }

        // Check if any programme contains the search query
        final programmes =
            discipline['programmes'] as List<Map<String, String>>;
        final programmeMatch = programmes.any((programme) => programme['name']
            .toString()
            .toLowerCase()
            .contains(programmeQuery));

        return disciplineMatch && programmeMatch;
      }).toList();
    });
  }

  void _initializeDisciplineData() {
    allDisciplines = [
      {
        'name': 'Mechanical Engineering (ME)',
        'programmes': [
          {'name': 'B.Tech ME', 'route': '/programme/btech-me'},
          {'name': 'M.Tech ME', 'route': '/programme/mtech-me'},
          {'name': 'Phd in ME', 'route': '/programme/phd-me'},
        ],
      },
      {
        'name': 'Electronics and Communication Engineering (ECE)',
        'programmes': [
          {'name': 'M.Tech ECE', 'route': '/programme/mtech-ece'},
          {'name': 'Phd in ECE', 'route': '/programme/phd-ece'},
          {'name': 'B.Tech ECE', 'route': '/programme/btech-ece'},
        ],
      },
      {
        'name': 'Mechatronics (MT)',
        'programmes': [
          {
            'name': 'M. Tech Mechatronics',
            'route': '/programme/mtech-mechatronics'
          },
        ],
      },
      {
        'name': 'Design (Des.)',
        'programmes': [
          {'name': 'B.Design', 'route': '/programme/bdesign'},
          {'name': 'PhD in Design', 'route': '/programme/phd-design'},
          {'name': 'M.Des Design', 'route': '/programme/mdes-design'},
        ],
      },
      {
        'name': 'Natural Sciences - Mathematics (Maths)',
        'programmes': [
          {'name': 'PhD in Maths', 'route': '/programme/phd-maths'},
        ],
      },
      {
        'name': 'Natural Sciences - Physics (Physics)',
        'programmes': [
          {'name': 'PhD in Physics', 'route': '/programme/phd-physics'},
        ],
      },
      {
        'name': 'Humanities - English (English)',
        'programmes': [
          {'name': 'PhD in English', 'route': '/programme/phd-english'},
        ],
      },
      {
        'name': 'Smart Manufacturing (SM)',
        'programmes': [
          {'name': 'M.Tech SM', 'route': '/programme/mtech-sm'},
          {'name': 'B.Tech SM', 'route': '/programme/btech-sm'},
        ],
      },
      {
        'name': 'Computer Science and Engineering (CSE)',
        'programmes': [
          {'name': 'M.Tech CSE', 'route': '/programme/mtech-cse'},
          {'name': 'Phd in CSE', 'route': '/programme/phd-cse'},
        ],
      },
    ];
  }

  Widget _buildFormField({required String label, required Widget child}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Discipline',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormField(
                    label: 'Discipline',
                    child: TextField(
                      controller: _disciplineController,
                      onChanged: (_) => _filterDisciplines(),
                      decoration: InputDecoration(
                        hintText: 'Search by Discipline',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFormField(
                    label: 'Programme',
                    child: TextField(
                      controller: _programmeController,
                      onChanged: (_) => _filterDisciplines(),
                      decoration: InputDecoration(
                        hintText: 'Search by Programme',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _filterDisciplines,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Search Disciplines'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text(
                        'Discipline Results',
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
                              content: Text('Exporting disciplines to Excel'),
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
                    child: filteredDisciplines.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'No disciplines match your search criteria',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredDisciplines.length,
                            itemBuilder: (context, index) {
                              final discipline = filteredDisciplines[index];
                              final programmes = discipline['programmes']
                                  as List<Map<String, String>>;

                              return Container(
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.grey.shade100
                                      : Colors.white,
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    discipline['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Wrap(
                                    spacing: 8.0,
                                    children: programmes.map((programme) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProgrammeDetailsScreen(
                                                programmeName:
                                                    programme['name'] ??
                                                        'Unknown Programme',
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          backgroundColor: Colors.blue.shade700,
                                          foregroundColor: Colors.white,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: Text(
                                          programme['name'] ??
                                              'Unknown Programme',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
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
    );
  }
}
