import 'package:flutter/material.dart';

class Course {
  final String code;
  final String name;
  final int credits;
  int? priority;

  Course({
    required this.code,
    required this.name,
    required this.credits,
    this.priority,
  });
}

class CourseSelectionScreen extends StatefulWidget {
  const CourseSelectionScreen({super.key});

  @override
  State<CourseSelectionScreen> createState() => _CourseSelectionScreenState();
}

class _CourseSelectionScreenState extends State<CourseSelectionScreen> {
  final List<Course> courses = [
    Course(code: 'NS103a', name: 'Linear Algebra', credits: 3, priority: 2),
    Course(code: 'OE3003', name: 'Lighting Design', credits: 3, priority: 3),
    Course(code: 'CS3001', name: 'Operating System', credits: 3, priority: 1),
    Course(code: 'OE3001', name: 'Modern Physics', credits: 3, priority: 4),
    Course(code: 'OE3002', name: 'Deep Learning', credits: 3, priority: 6),
    Course(code: 'OE3004', name: 'System Design', credits: 3, priority: 5),
  ];

  void _changePriority(int index, int? newPriority) {
    if (newPriority == null || newPriority < 1) return;

    final existingIndex =
        courses.indexWhere((course) => course.priority == newPriority);

    setState(() {
      if (existingIndex != -1 && existingIndex != index) {
        courses[existingIndex].priority = courses[index].priority;
      }
      courses[index].priority = newPriority;
    });
  }

  void _saveCourses() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Course saved successfully!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Delay before navigating back
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0085FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Fusion',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 8),
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 8),
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: const Color(0xFF0085FF),
            child: const Text(
              'Add Course - Elective 1',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: const Color(0xFF0085FF).withOpacity(0.6),
            child: Row(
              children: const [
                SizedBox(width: 4),
                Expanded(
                    flex: 2,
                    child: Text('Course Code',
                        style: TextStyle(color: Colors.white))),
                Expanded(
                    flex: 3,
                    child: Text('Course Name',
                        style: TextStyle(color: Colors.white))),
                Expanded(
                    child: Text('Credits',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center)),
                Expanded(
                    child: Text('Priority',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                final bgColor = index % 2 == 0
                    ? const Color(0xFFB2E7E9).withOpacity(0.3)
                    : const Color(0xFFB2E7E9).withOpacity(0.5);

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: bgColor,
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      Expanded(flex: 2, child: Text(course.code)),
                      Expanded(flex: 3, child: Text(course.name)),
                      Expanded(
                          child: Text('${course.credits}',
                              textAlign: TextAlign.center)),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: course.priority,
                              icon: const Icon(Icons.arrow_drop_down, size: 18),
                              onChanged: (value) =>
                                  _changePriority(index, value),
                              isExpanded: true,
                              items: List.generate(
                                courses.length,
                                (i) => DropdownMenuItem<int>(
                                  value: i + 1,
                                  child: Center(child: Text('${i + 1}')),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _saveCourses,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Save'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
