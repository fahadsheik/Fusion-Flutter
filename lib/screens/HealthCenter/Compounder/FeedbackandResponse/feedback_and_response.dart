import 'package:flutter/material.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../../utils/gesture_sidebar.dart';
import '../../../../utils/sidebar.dart';

class FeedbackAndResponse extends StatefulWidget {
  const FeedbackAndResponse({super.key});

  @override
  State<FeedbackAndResponse> createState() => _FeedbackAndResponseState();
}

class _FeedbackAndResponseState extends State<FeedbackAndResponse> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> _feedbackData = [
    {
      'name': 'John Doe',
      'feedback': 'Great service! Very satisfied with the support team.',
    },
    {
      'name': 'Jane Smith',
      'feedback': 'The platform is user-friendly and easy to navigate.',
    },
    {
      'name': 'Alice Johnson',
      'feedback': 'Could improve the response time for queries.',
    },
    {
      'name': 'Bob Brown',
      'feedback': 'Excellent features, but the app crashes sometimes.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'View Feedback',
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
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Feedback By',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Feedback',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _feedbackData.length,
                    itemBuilder: (context, index) {
                      final data = _feedbackData[index];
                      final isAlternate = index % 2 == 1;
                      
                      return Container(
                        padding: const EdgeInsets.all(16),
                        color: isAlternate ? const Color(0xFFE6FBFA) : null,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                data['name'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(data['feedback'] ?? ''),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }
}