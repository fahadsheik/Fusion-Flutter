import 'package:flutter/material.dart';
import 'registration_page.dart';

class Course {
  final String code;
  final String name;

  Course({
    required this.code,
    required this.name,
  });

  String get fullName => '$code $name';
}

class BacklogFormScreen extends StatefulWidget {
  const BacklogFormScreen({super.key});

  @override
  State<BacklogFormScreen> createState() => _BacklogFormScreenState();
}

class _BacklogFormScreenState extends State<BacklogFormScreen> {
  final List<Course> availableCourses = [
    Course(code: 'CS1002', name: 'Data Algorithm Analysis'),
    Course(code: 'CS3001', name: 'Computer Network'),
    Course(code: 'CS3002', name: 'Data Structures'),
    Course(code: 'CS2001', name: 'Introduction to C'),
    Course(code: 'CS2003', name: 'Data Algorithm Analysis'),
    Course(code: 'CS2005', name: 'Computer Organization Architecture'),
  ];

  List<String?> selectedCourses = [null];

  void addAnotherCourse() {
    setState(() {
      selectedCourses.add(null);
    });
  }

  void showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Applied Successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  void goBackToRegistrationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFF0085FF), width: 2),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Avijit Biswas',
                      style: TextStyle(
                        color: Color(0xFF0085FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'CSE student',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fill Backlog Form',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select Course to apply for backlog',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(selectedCourses.length, (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedCourses[index],
                              hint: const Text('Select a course'),
                              items: availableCourses.map((Course course) {
                                return DropdownMenuItem<String>(
                                  value: course.fullName,
                                  child: Text(course.fullName),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedCourses[index] = value;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: addAnotherCourse,
                        icon: const Icon(Icons.add_circle_outline,
                            color: Color(0xFF0085FF)),
                        label: const Text(
                          'Add another course',
                          style: TextStyle(
                            color: Color(0xFF0085FF),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          side: const BorderSide(color: Color(0xFF0085FF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: showSuccessPopup,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0085FF),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Apply for Backlog'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 120,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: goBackToRegistrationPage,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey,
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Back'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFF0085FF),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.book, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
