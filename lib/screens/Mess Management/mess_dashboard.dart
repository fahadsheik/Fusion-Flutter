import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion/screens/Mess%20Management/deregistration_screen.dart';
import 'package:fusion/screens/Mess%20Management/feedback_screen.dart';
import 'package:fusion/screens/Mess%20Management/mess_activities_screen.dart';
import 'package:fusion/screens/Mess%20Management/mess_announcement_screen.dart';
import 'package:fusion/screens/Mess%20Management/rebate_request_screen.dart';
import 'package:fusion/screens/Mess%20Management/registration_screen.dart';
import 'package:fusion/screens/Mess%20Management/requests_screen.dart';
import 'package:fusion/screens/Mess%20Management/respond_to_rebate_screen.dart';
import 'package:fusion/screens/Mess%20Management/update_payment_screen.dart';
import 'package:fusion/screens/Mess%20Management/update_semester_dates_screen.dart';
import 'package:fusion/screens/Mess%20Management/view_bill_and_payments_screen.dart';
import 'package:fusion/screens/Mess%20Management/view_menu_screen.dart';
import 'package:fusion/screens/Mess%20Management/view_registrations_screen.dart';

import '../../main.dart';
import '../../utils/sidebar.dart' as sidebar;
import '../../utils/gesture_sidebar.dart';
import '../../utils/home.dart';

class MessDashboard extends StatefulWidget {
  const MessDashboard({super.key});

  @override
  State<MessDashboard> createState() => _MessDashboardState();
}

class _MessDashboardState extends State<MessDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleNavigation(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MessAnnouncementScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewMenuScreen()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    } else if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const FeedbackScreen()),
      );
    } else if (index == 6) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DeregistrationScreen()),
      );
    } else if (index == 7) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UpdatePaymentScreen()),
      );
    } else if (index == 8) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RebateRequestScreen()),
      );
    } else if (index == 9) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewBillAndPaymentsScreen()),
      );
    }
    else if (index == 10) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MessActivitiesScreen()),
      );
    }
    else if (index == 11) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UpdateSemesterDatesScreen()),
      );
    }
    else if (index == 12) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewRegistrationsScreen()),
      );
    }
    else if (index == 13) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RequestsScreen()),
      );
    }
    else if (index == 14) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RespondToRebateScreen()),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigating to ${_getScreenName(index)}'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  String _getScreenName(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Orders';
      case 2:
        return 'Announcement';
      case 3:
        return 'Submit Grades';
      case 4:
        return 'Verify Grades';
      case 5:
        return 'Generate Transcript';
      case 6:
        return 'Validate Grades';
      case 7:
        return 'Update Grades';
      case 8:
        return 'Result';
      case 9:
        return 'Profile';
      case 10:
        return 'Settings';
      case 11:
        return 'Help';
      case 12:
        return 'Log out';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Navigate to home screen
          await Future.delayed(Duration.zero); // Add small delay to prevent navigation conflicts
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
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Mess Management',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            elevation: 0,
            backgroundColor: Colors.blue.shade700,
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
                  // Navigate to home screen when notification bell is clicked
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
          drawer: sidebar.Sidebar(onItemSelected: _handleNavigation),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
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
                    children: [
                      _buildDashboardCard(
                        icon: Icons.campaign,
                        label: 'Announcement',
                        color: Colors.orange,
                        onTap: () => _handleNavigation(2),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.restaurant_menu,
                        label: 'View Menu',
                        color: Colors.green,
                        onTap: () => _handleNavigation(3),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.app_registration,
                        label: 'Registration',
                        color: Colors.purple,
                        onTap: () => _handleNavigation(4),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.feedback,
                        label: 'Feedback',
                        color: Colors.blue,
                        onTap: () => _handleNavigation(5),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.developer_board_off,
                        label: 'Deregistration',
                        color: Colors.red,
                        onTap: () => _handleNavigation(6),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.payment,
                        label: 'Update Payment',
                        color: Colors.teal,
                        onTap: () => _handleNavigation(7),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.money_off,
                        label: 'Rebate Request',
                        color: Colors.indigo,
                        onTap: () => _handleNavigation(8),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.payment,
                        label: 'View Bill and Payments',
                        color: Colors.indigo,
                        onTap: () => _handleNavigation(9),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.local_activity,
                        label: 'Mess Activities',
                        color: Colors.indigo,
                        onTap: () => _handleNavigation(10),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.calendar_month,
                        label: 'Update Semester Dates',
                        color: Colors.indigo,
                        onTap: () => _handleNavigation(11),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.how_to_reg_rounded,
                        label: 'View Registrations',
                        color: Colors.indigo,
                        onTap: () => _handleNavigation(12),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.request_page,
                        label: 'Requests',
                        color: Colors.indigo,
                        onTap: () => _handleNavigation(13),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.money,
                        label: 'Respond to Rebate',
                        color: Colors.indigo,
                        onTap: () => _handleNavigation(14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
    required Color color, // This parameter will no longer be used for color
    required VoidCallback onTap,
  }) {
    // Using the specific blue shade for all cards and icons
    Color cardColor = Colors.blue.shade700;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100, // Fixed height for rectangle cards
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              cardColor,
              cardColor.withOpacity(0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              right: -15,
              bottom: -15,
              child: Icon(
                icon,
                size: 100,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // Icon in circle
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: cardColor.withOpacity(0.2), // Changed to use cardColor instead of color
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      size: 30.0,
                      color: cardColor, // Changed to use cardColor instead of color
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  // Text content
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.7),
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
