import 'package:flutter/material.dart';
import '../../../utils/bottom_bar.dart';
import '../../../utils/gesture_sidebar.dart';
import '../../../utils/sidebar.dart';
import '../../../utils/home.dart';
import 'PatientLog/update_patient_log.dart';
import 'PatientLog/history.dart';
import 'ManageStock/add_stock.dart';
import 'ManageStock/view_stock.dart';
import 'ManageStock/edit_threshold.dart';
import 'ManageStock/add_medicine.dart';
import 'ManageStock/required_medicine.dart';
import 'ManageStock/expired_medicine.dart';
import 'Schedule/view_doctor_schedule.dart';
import 'Schedule/edit_doctor_schedule.dart';
import 'Schedule/view_pathologist_schedule.dart';
import 'Schedule/edit_pathologist_schedule.dart';
import 'FeedbackandResponse/feedback_and_response.dart';
import 'Announcements/make_announcements.dart';
import 'Announcements/announcements_record.dart';

class HealthDashboard extends StatefulWidget {
  const HealthDashboard({super.key});

  @override
  State<HealthDashboard> createState() => _HealthDashboardState();
}

class _HealthDashboardState extends State<HealthDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? _expandedIndex;

  void _handleNavigation(int index) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected option $index'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  final List<Map<String, dynamic>> _dashboardItems = [
    {
      'title': 'Patient Log',
      'icon': Icons.people,
      'subheadings': [
        'Update Patient Log',
        'History',
      ],
    },
    {
      'title': 'Manage Stock',
      'icon': Icons.inventory_2,
      'subheadings': [
        'Add Stock',
        'Add Medicine',
        'Edit Threshold',
        'Expired Medicine',
        'View Stock',
        'Required Medicine',
      ],
    },
    {
      'title': 'Schedule',
      'icon': Icons.calendar_today,
      'subheadings': [
        'View Doctor Schedule',
        'Edit Doctor Schedule',
        'View Pathologist Schedule',
        'Edit Doctor Schedule',
      ],
    },
    {
      'title': 'Feedback/Response',
      'icon': Icons.feedback,
      'subheadings': [],
    },
    {
      'title': 'Announcements',
      'icon': Icons.campaign,
      'subheadings': [
        'Make Announcements',
        'Announcements Record',
      ],
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          await Future.delayed(Duration.zero);
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        }
      },
      child: GestureSidebar(
        scaffoldKey: _scaffoldKey,
        edgeWidthFactor: 1.0,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Health Center',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            elevation: 0,
            backgroundColor: const Color(0xFF1386E4), // Primary Blue
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
          drawer: Sidebar(onItemSelected: _handleNavigation),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1386E4), // Primary Blue
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 6.0, top: 10.0),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ..._dashboardItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return Column(
                          children: [
                            _buildDashboardCard(
                              icon: item['icon'] as IconData,
                              label: item['title'] as String,
                              onTap: () {
                                if (item['title'] == 'Feedback/Response') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FeedbackAndResponse(),
                                    ),
                                  );
                                } else if (item['title'] == 'Make Announcements') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MakeAnnouncements(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _expandedIndex = _expandedIndex == index ? null : index;
                                  });
                                }
                              },
                              isExpanded: _expandedIndex == index,
                              subheadings: List<String>.from(item['subheadings'] as List),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BottomBar(),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isExpanded,
    required List<String> subheadings,
  }) {
    return Column(
      children: [
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF1386E4), // Primary Blue
                    Color(0xFF1386E4), // Primary Blue at 60% opacity
                    Color(0x991386E4), // Primary Blue at 40% opacity
                  ],
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA5F1E9), // Soft Teal
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 30.0,
                      color: const Color(0xFF1386E4), // Primary Blue
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white.withOpacity(0.7),
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded && subheadings.isNotEmpty)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x261386E4), // Primary Blue at 15% opacity
                  Color(0x1A1386E4), // Primary Blue at 10% opacity
                ],
              ),
            ),
            child: Column(
              children: subheadings.map((subheading) => ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                title: Text(
                  subheading,
                  style: const TextStyle(
                    color: Color(0xFF1386E4), // Primary Blue
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF79E0EE), // Cyan Blue
                ),
                onTap: () {
                  if (subheading == 'Update Patient Log') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdatePatientLog(),
                      ),
                    );
                  } else if (subheading == 'History') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PatientHistory(),
                      ),
                    );
                  } else if (subheading == 'Add Stock') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddStock(),
                      ),
                    );
                  } else if (subheading == 'Feedback/Response') {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const FeedbackAndResponse(),
    ),
  );
}
                  
                  else if (subheading == 'Add Medicine') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddMedicine(),
                      ),
                    );
                  } else if (subheading == 'Edit Threshold') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditThreshold(),
                      ),
                    );
                  } else if (subheading == 'View Stock') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewStock(),
                      ),
                    );
                  } else if (subheading == 'Required Medicine') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequiredMedicine(),
                      ),
                    );
                  } else if (subheading == 'Expired Medicine') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpiredMedicine(),
                      ),
                    );
                  } else if (subheading == 'View Doctor Schedule') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewDoctorSchedule(),
                      ),
                    );
                  } else if (subheading == 'Edit Doctor Schedule') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditDoctorSchedule(),
                      ),
                    );
                  } else if (subheading == 'View Pathologist Schedule') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewPathologistSchedule(),
                      ),
                    );
                  } else if (subheading == 'Edit Pathologist Schedule') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditPathologistSchedule(),
                      ),
                    );
                  } else if (subheading == 'Make Announcements') {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const MakeAnnouncements(),
                     ),
                   );
                  } else if (subheading == 'Announcements Record') {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const AnnouncementsRecord(),
                     ),
                   );
                  } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text('Selected: $subheading'),
                       backgroundColor: const Color(0xFF1386E4), // Primary Blue
                     ),
                   );
                  }
                },
              )).toList(),
            ),
          ),
      ],
    );
  }
}
