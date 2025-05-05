import 'package:flutter/material.dart';
import 'registration_page.dart';

class Course {
  final String code;
  final String name;
  final int credits;

  Course({
    required this.code,
    required this.name,
    required this.credits,
  });
}

class DropReplaceCoursesScreen extends StatefulWidget {
  const DropReplaceCoursesScreen({super.key});

  @override
  State<DropReplaceCoursesScreen> createState() =>
      _DropReplaceCoursesScreenState();
}

class _DropReplaceCoursesScreenState extends State<DropReplaceCoursesScreen> {
  final List<Course> courses = [
    Course(code: 'NS103a', name: 'Linear Algebra', credits: 3),
    Course(code: 'OE3003', name: 'Lighting Design', credits: 3),
    Course(code: 'CS3001', name: 'Operating System', credits: 3),
    Course(code: 'OE3001', name: 'Modern Physics', credits: 3),
    Course(code: 'OE3002', name: 'Deep Learning', credits: 3),
    Course(code: 'OE3004', name: 'System Design', credits: 3),
  ];

  final List<Course> availableCourses = [
    Course(code: 'CS3002', name: 'Database Systems', credits: 4),
    Course(code: 'OE3005', name: 'Computer Networks', credits: 3),
    Course(code: 'NS104b', name: 'Calculus', credits: 3),
    Course(code: 'OE3006', name: 'Digital Systems', credits: 4),
  ];

  void _showDropConfirmation(Course course) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Drop'),
          content: Text('Are you sure you want to drop ${course.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${course.name} has been dropped')),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Drop'),
            ),
          ],
        );
      },
    );
  }

  void _showReplaceDialog(Course course) {
    String? selectedCourseCode;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Replace Course'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select a course to replace ${course.name}:'),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCourseCode,
                          hint: const Text('Select a course'),
                          items: availableCourses.map((Course course) {
                            return DropdownMenuItem<String>(
                              value: course.code,
                              child: Text('${course.code} - ${course.name}'),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setDialogState(() {
                              selectedCourseCode = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: selectedCourseCode == null
                      ? null
                      : () {
                          final replacementCourse = availableCourses.firstWhere(
                            (c) => c.code == selectedCourseCode,
                          );
                          final courseIndex = courses.indexOf(course);
                          Navigator.of(context).pop();
                          setState(() {
                            courses[courseIndex] = replacementCourse;
                            availableCourses.removeWhere(
                                (c) => c.code == selectedCourseCode);
                            availableCourses.add(course);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${course.name} has been replaced with ${replacementCourse.name}',
                              ),
                            ),
                          );
                        },
                  child: const Text('Replace'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              color: Colors.white, height: MediaQuery.of(context).padding.top),
          _buildHeader(),
          _buildTitleBar(),
          _buildTableHeader(),
          Expanded(child: _buildCourseList()),
          _buildButtons(),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Avijit Biswas',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text('CSE student',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            ],
          ),
          const Spacer(),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: const Text(
        'Drop / Replace Courses',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF3498DB),
      child: Row(
        children: const [
          Expanded(
              flex: 2,
              child: Text('Course Code',
                  style: TextStyle(color: Colors.white, fontSize: 12))),
          Expanded(
              flex: 3,
              child: Text('Course Name',
                  style: TextStyle(color: Colors.white, fontSize: 12))),
          Expanded(
              child: Text('Credits',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center)),
          Expanded(
              flex: 2,
              child: Text('Action',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildCourseList() {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: const Color(0xFFB2E7E9).withOpacity(0.3),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child:
                      Text(course.code, style: const TextStyle(fontSize: 12))),
              Expanded(
                  flex: 3,
                  child:
                      Text(course.name, style: const TextStyle(fontSize: 12))),
              Expanded(
                  child: Text(course.credits.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12))),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () => _showBottomOptions(course),
                  child: const Center(
                    child: Text('Drop/Replace',
                        style: TextStyle(fontSize: 12, color: Colors.green)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomOptions(Course course) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 120,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Drop Course'),
                onTap: () {
                  Navigator.pop(context);
                  _showDropConfirmation(course);
                },
              ),
              ListTile(
                title: const Text('Replace Course'),
                onTap: () {
                  Navigator.pop(context);
                  _showReplaceDialog(course);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Courses submitted successfully!')),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Submit'),
            ),
          ),
          SizedBox(
            width: 150,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationPage()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Back'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 56,
      decoration: const BoxDecoration(color: Color(0xFF0085FF)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.book, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {}),
        ],
      ),
    );
  }
}
