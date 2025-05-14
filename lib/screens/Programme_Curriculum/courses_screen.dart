import 'package:flutter/material.dart';
import '../../utils/bottom_bar.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/home.dart';

// Add CourseDetailsScreen class inside the same file for simplicity
class CourseDetailsScreen extends StatelessWidget {
  final String courseCode;
  final String courseName;
  final String version;
  final int credits;
  final String department;

  const CourseDetailsScreen({
    Key? key,
    required this.courseCode,
    required this.courseName,
    required this.version,
    required this.credits,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course: $courseCode',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course title and info card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Course Code', courseCode),
                    _buildInfoRow('Version', version),
                    _buildInfoRow('Credits', credits.toString()),
                    _buildInfoRow('Department', department),
                    _buildInfoRow('Status', 'Active'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Course description section
            const Text(
              'Course Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This course provides a comprehensive introduction to the fundamentals of the subject, '
              'covering theoretical concepts and practical applications through hands-on exercises and projects.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            // Learning objectives section
            const Text(
              'Learning Objectives',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Understand core concepts and principles'),
            _buildBulletPoint('Develop analytical and problem-solving skills'),
            _buildBulletPoint(
                'Apply theoretical knowledge to practical scenarios'),
            _buildBulletPoint(
                'Gain proficiency in relevant tools and technologies'),

            const SizedBox(height: 24),

            // Prerequisites section
            const Text(
              'Prerequisites',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('None required for $courseCode'),

            const SizedBox(height: 24),

            // Syllabus outline section
            const Text(
              'Syllabus Outline',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Week 1-2: Introduction to core concepts'),
            _buildBulletPoint('Week 3-4: Theoretical foundations'),
            _buildBulletPoint('Week 5-7: Applied techniques and methodologies'),
            _buildBulletPoint('Week 8-9: Advanced topics and case studies'),
            _buildBulletPoint(
                'Week 10-12: Practical applications and projects'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controllers for the filter fields
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  final TextEditingController _creditsController = TextEditingController();

  // Dummy table data (can be replaced with API data in the future)
  final List<Map<String, dynamic>> _coursesData = [
    {
      'code': 'CS101',
      'name': 'Introduction to Computer Science',
      'version': '2.0',
      'credits': 4,
      'department': 'Computer Science',
      'status': 'Active'
    },
    {
      'code': 'CS201',
      'name': 'Data Structures and Algorithms',
      'version': '1.5',
      'credits': 4,
      'department': 'Computer Science',
      'status': 'Active'
    },
    {
      'code': 'CS301',
      'name': 'Database Systems',
      'version': '2.0',
      'credits': 3,
      'department': 'Computer Science',
      'status': 'Active'
    },
    {
      'code': 'MATH101',
      'name': 'Calculus I',
      'version': '1.0',
      'credits': 3,
      'department': 'Mathematics',
      'status': 'Active'
    },
    {
      'code': 'MATH201',
      'name': 'Linear Algebra',
      'version': '1.2',
      'credits': 3,
      'department': 'Mathematics',
      'status': 'Active'
    },
    {
      'code': 'PHYS101',
      'name': 'Physics for Engineers',
      'version': '1.0',
      'credits': 4,
      'department': 'Physics',
      'status': 'Active'
    },
    {
      'code': 'ENG202',
      'name': 'Technical Writing',
      'version': '1.5',
      'credits': 2,
      'department': 'English',
      'status': 'Active'
    },
    {
      'code': 'CS401',
      'name': 'Machine Learning',
      'version': '2.0',
      'credits': 4,
      'department': 'Computer Science',
      'status': 'Active'
    },
    {
      'code': 'CS402',
      'name': 'Artificial Intelligence',
      'version': '2.1',
      'credits': 4,
      'department': 'Computer Science',
      'status': 'Active'
    },
    {
      'code': 'HIST101',
      'name': 'World History',
      'version': '1.0',
      'credits': 3,
      'department': 'History',
      'status': 'Active'
    },
    {
      'code': 'ECO201',
      'name': 'Microeconomics',
      'version': '1.5',
      'credits': 3,
      'department': 'Economics',
      'status': 'Active'
    },
    {
      'code': 'CS350',
      'name': 'Operating Systems',
      'version': '1.8',
      'credits': 4,
      'department': 'Computer Science',
      'status': 'Active'
    },
    {
      'code': 'CS500',
      'name': 'Advanced Programming',
      'version': '3.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS501',
      'name': 'Compiler Design',
      'version': '2.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS502',
      'name': 'Cloud Computing',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS503',
      'name': 'Cyber Security',
      'version': '2.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS504',
      'name': 'Data Mining',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS505',
      'name': 'Artificial Neural Networks',
      'version': '2.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS506',
      'name': 'IoT Systems',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS507',
      'name': 'Blockchain Technology',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS508',
      'name': 'Quantum Computing',
      'version': '2.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS509',
      'name': 'Big Data Analytics',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS510',
      'name': 'Software Testing',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS511',
      'name': 'Game Development',
      'version': '2.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS512',
      'name': 'Mobile App Development',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS513',
      'name': 'Web Development',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS514',
      'name': 'Machine Vision',
      'version': '2.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS515',
      'name': 'Natural Language Processing',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS516',
      'name': 'Robotics',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS517',
      'name': 'Augmented Reality',
      'version': '2.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS518',
      'name': 'Virtual Reality',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS519',
      'name': 'Digital Signal Processing',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS520',
      'name': 'Embedded Systems',
      'version': '2.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS521',
      'name': 'Parallel Computing',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS522',
      'name': 'Distributed Systems',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS523',
      'name': 'Human-Computer Interaction',
      'version': '2.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS524',
      'name': 'Digital Forensics',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS525',
      'name': 'Ethical Hacking',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS526',
      'name': 'Advanced Databases',
      'version': '2.0',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS527',
      'name': 'Software Architecture',
      'version': '1.0',
      'credits': 3,
      'department': 'CS',
      'status': 'Active'
    },
    {
      'code': 'CS528',
      'name': 'Advanced Algorithms',
      'version': '1.5',
      'credits': 4,
      'department': 'CS',
      'status': 'Active'
    },
  ];

  // Filtered data
  late List<Map<String, dynamic>> _filteredData;

  // Track current course index for iteration
  int _currentCourseIndex = 0;

  String? _selectedYear;
  String? _selectedSemester;
  String? _selectedDepartment;
  bool _isLoading = false;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _filteredData = List.from(_coursesData);
  }

  @override
  void dispose() {
    _courseCodeController.dispose();
    _courseNameController.dispose();
    _versionController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  // Apply filters to data
  void _filterData() {
    final String codeFilter = _courseCodeController.text.toLowerCase();
    final String nameFilter = _courseNameController.text.toLowerCase();
    final String versionFilter = _versionController.text.toLowerCase();
    final String creditsFilter = _creditsController.text.toLowerCase();

    setState(() {
      _filteredData = _coursesData.where((course) {
        final codeMatch = codeFilter.isEmpty ||
            course['code'].toString().toLowerCase().contains(codeFilter);
        final nameMatch = nameFilter.isEmpty ||
            course['name'].toString().toLowerCase().contains(nameFilter);
        final versionMatch = versionFilter.isEmpty ||
            course['version'].toString().toLowerCase().contains(versionFilter);
        final creditsMatch = creditsFilter.isEmpty ||
            course['credits'].toString().toLowerCase().contains(creditsFilter);

        return codeMatch && nameMatch && versionMatch && creditsMatch;
      }).toList();
    });
  }

  // Reset filters
  void _resetFilters() {
    setState(() {
      _courseCodeController.clear();
      _courseNameController.clear();
      _versionController.clear();
      _creditsController.clear();
      _filteredData = List.from(_coursesData);
    });
  }

  // Handle course code click - modified to navigate to detail screen
  void _handleCourseClick(String courseCode, String courseName) {
    // Find the course details from the filtered data
    Map<String, dynamic> course = _filteredData.firstWhere(
      (course) => course['code'] == courseCode,
      orElse: () => {
        'code': courseCode,
        'name': courseName,
        'version': 'N/A',
        'credits': 0,
        'department': 'Unknown',
        'status': 'Unknown'
      },
    );

    // Navigate to the course details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailsScreen(
          courseCode: course['code'] as String,
          courseName: course['name'] as String,
          version: course['version'].toString(),
          credits: course['credits'] as int,
          department: course['department'] as String,
        ),
      ),
    );
  }

  // Show course details with navigation options
  void _showCourseDetailsDialog(String courseCode, String courseName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Course Details: $courseCode'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Course: $courseName'),
                const SizedBox(height: 8),
                const Text(
                    'This would display detailed course information, including:'),
                const SizedBox(height: 8),
                const Text('• Course description'),
                const Text('• Prerequisites'),
                const Text('• Learning objectives'),
                const Text('• Syllabus topics'),
                const Text('• Assessment methods'),
                const Text('• Recommended readings'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentCourseIndex > 0)
                  TextButton(
                    child: const Text('Previous'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showPreviousCourse();
                    },
                  ),
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                if (_currentCourseIndex < _filteredData.length - 1)
                  TextButton(
                    child: const Text('Next'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showContinueIterationDialog();
                    },
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Show the "Continue to iterate?" confirmation dialog
  void _showContinueIterationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Continue to iterate?'),
          content: const Text('Would you like to view the next course?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _showNextCourse();
              },
            ),
          ],
        );
      },
    );
  }

  // Show the previous course
  void _showPreviousCourse() {
    if (_currentCourseIndex > 0) {
      _currentCourseIndex--;
      final previousCourse = _filteredData[_currentCourseIndex];
      _showCourseDetailsDialog(
        previousCourse['code'] as String,
        previousCourse['name'] as String,
      );
    }
  }

  // Show the next course
  void _showNextCourse() {
    if (_currentCourseIndex < _filteredData.length - 1) {
      _currentCourseIndex++;
      final nextCourse = _filteredData[_currentCourseIndex];
      _showCourseDetailsDialog(
        nextCourse['code'] as String,
        nextCourse['name'] as String,
      );
    }
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
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      edgeWidthFactor: 1.0,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Courses',
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
                      label: 'Course Code',
                      child: TextField(
                        controller: _courseCodeController,
                        decoration: InputDecoration(
                          hintText: 'Search by Code',
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
                      label: 'Course Name',
                      child: TextField(
                        controller: _courseNameController,
                        decoration: InputDecoration(
                          hintText: 'Search by Course Name',
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
                      label: 'Version',
                      child: TextField(
                        controller: _versionController,
                        decoration: InputDecoration(
                          hintText: 'Search by Version',
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
                      label: 'Credits',
                      child: TextField(
                        controller: _creditsController,
                        decoration: InputDecoration(
                          hintText: 'Search by Credits',
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
                        child: const Text('Search Courses'),
                      ),
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
                                label: Text('Course Code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Course Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Version',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Credits',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: _filteredData
                              .map(
                                (course) => DataRow(
                                  cells: [
                                    DataCell(
                                      InkWell(
                                        child: Text(
                                          course['code'] as String,
                                          style: TextStyle(
                                            color: Colors.blue.shade700,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        onTap: () => _handleCourseClick(
                                          course['code'] as String,
                                          course['name'] as String,
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(course['name'] as String)),
                                    DataCell(
                                        Text(course['version'].toString())),
                                    DataCell(
                                        Text(course['credits'].toString())),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (_showResults) ...[
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Text(
                            'Course Results',
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
                                  content: Text('Exporting courses to Excel'),
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
                              (Set<MaterialState> states) =>
                                  Colors.grey.shade100,
                            ),
                            columns: const [
                              DataColumn(
                                  label: Text('Course Code',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Course Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Version',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Credits',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ],
                            rows: _filteredData
                                .map(
                                  (course) => DataRow(
                                    cells: [
                                      DataCell(Text(course['code'] as String)),
                                      DataCell(Text(course['name'] as String)),
                                      DataCell(
                                          Text(course['version'].toString())),
                                      DataCell(
                                          Text(course['credits'].toString())),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
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
