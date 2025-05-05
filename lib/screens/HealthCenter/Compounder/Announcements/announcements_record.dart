import 'package:flutter/material.dart';
import '../../../../../utils/bottom_bar.dart';
import '../../../../../utils/gesture_sidebar.dart';
import '../../../../../utils/sidebar.dart';

class AnnouncementsRecord extends StatefulWidget {
  const AnnouncementsRecord({super.key});

  @override
  State<AnnouncementsRecord> createState() => _AnnouncementsRecordState();
}

class _AnnouncementsRecordState extends State<AnnouncementsRecord> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final List<Map<String, String>> _announcements = [
    {
      'title': 'Announcement Title 1',
      'date': 'October 10, 2023',
      'content': 'This is a sample announcement for testing purposes. It contains important information about upcoming events.',
    },
    {
      'title': 'Announcement Title 2',
      'date': 'October 12, 2023',
      'content': 'This is another sample announcement. It provides details about new policies and procedures.',
    },
    {
      'title': 'Announcement Title 3',
      'date': 'October 15, 2023',
      'content': 'This announcement is about a scheduled maintenance activity. Please plan accordingly.',
    },
    {
      'title': 'Announcement Title 4',
      'date': 'October 18, 2023',
      'content': 'This is a reminder about the upcoming deadline for submissions. Ensure all documents are submitted on time.',
    },
  ];

  void _handleDelete(int index) {
    setState(() {
      _announcements.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Announcement deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Announcements Record',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue.shade700,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Sidebar(onItemSelected: (index) {}),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _announcements.length,
            itemBuilder: (context, index) {
              final announcement = _announcements[index];
              
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: index % 2 == 0 ? const Color(0xFFE6FBFA) : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        announcement['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        announcement['date'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        announcement['content'] ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.blue.shade700,
                            onPressed: () {
                              // Navigate to edit page
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Edit functionality to be implemented'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => _handleDelete(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to add announcement page
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Add announcement functionality to be implemented'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          backgroundColor: Colors.blue.shade700,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }
}