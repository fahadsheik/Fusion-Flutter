import 'package:flutter/material.dart';

class Course {
  final String code;
  final String name;
  final int credits;
  final String ltp;

  Course({
    required this.code,
    required this.name,
    required this.credits,
    required this.ltp,
  });
}

class OfferedCoursesPage extends StatelessWidget {
  const OfferedCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = [
      Course(code: 'NS103a', name: 'Linear Algebra', credits: 3, ltp: '3-1-0'),
      Course(code: 'OE3003', name: 'Lighting Design', credits: 3, ltp: '3-0-2'),
      Course(
          code: 'CS3001', name: 'Operating System', credits: 3, ltp: '3-1-1'),
      Course(code: 'OE3001', name: 'Modern Physics', credits: 3, ltp: '3-0-0'),
      Course(code: 'OE3002', name: 'Deep Learning', credits: 3, ltp: '3-1-0'),
      Course(code: 'OE3004', name: 'System Design', credits: 3, ltp: '3-0-2'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offered Courses'),
        backgroundColor: Colors.blue,
        elevation: 1,
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Registered Courses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF3498DB),
            child: Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Course Code',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Course Name',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Credits',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'L-T-P',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          // Course List
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: index % 2 == 0
                      ? const Color(0xFFB2E7E9).withOpacity(0.3)
                      : Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(course.code,
                            style: const TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(course.name,
                            style: const TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        child: Text(course.credits.toString(),
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text(course.ltp,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Back Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              width: 150,
              height: 40,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Back'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
