import 'package:flutter/material.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../../utils/gesture_sidebar.dart';
import '../../../../utils/sidebar.dart';

class ViewPathologistSchedule extends StatefulWidget {
  const ViewPathologistSchedule({super.key});

  @override
  State<ViewPathologistSchedule> createState() => _ViewPathologistScheduleState();
}

class _ViewPathologistScheduleState extends State<ViewPathologistSchedule> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> _scheduleData = [
    {
      'PathologistName': 'Dr GS Sandhu',
      'specialization': 'Dermitanologist',
      'day': 'Monday',
      'time': '5:30 PM',
    },
    {
      'PathologistName': 'Dr GS Sandhu',
      'specialization': 'Dermitanologist',
      'day': 'Tuesday',
      'time': '  NA',
    },
    {
      'PathologistName': 'Dr NC Gupta',
      'specialization': 'Physiotherapist',
      'day': 'Friday',
      'time': '5:30 PM',
    },
    {
      'PathologistName': 'Dr GS Sandhu',
      'specialization': 'Dermitanologist',
      'day': 'Thursday',
      'time': '5:30 PM',
    },
    {
      'PathologistName': 'Dr Rajiv Kapoor',
      'specialization': 'Neurologist',
      'day': 'Friday',
      'time': '3:30 PM',
    },
    {
      'PathologistName': 'Dr GS Sandhu',
      'specialization': 'Dermitanologist',
      'day': 'Saturday',
      'time': '5:30 PM',
    },
    {
      'PathologistName': 'Dr NC Gupta',
      'specialization': 'Physiotherapist',
      'day': 'Monday',
      'time': '5:30 PM',
    },
    {
      'PathologistName': 'Dr NC Gupta',
      'specialization': 'Physiotherapist',
      'day': 'Tuesday',
      'time': '5:30 PM',
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
            'View Pathologist Schedule',
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
                        flex: 2,
                        child: Text(
                          'Pathologist Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Specialization',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Day',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Time',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _scheduleData.length,
                    itemBuilder: (context, index) {
                      final data = _scheduleData[index];
                      final isAlternate = index % 2 == 1;
                      
                      return Container(
                        padding: const EdgeInsets.all(16),
                        color: isAlternate ? const Color(0xFFE6FBFA) : null,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(data['PathologistName'] ?? ''),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(data['specialization'] ?? ''),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(data['day'] ?? ''),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(data['time'] ?? ''),
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