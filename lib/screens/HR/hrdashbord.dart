import 'package:flutter/material.dart';
import '../../utils/sidebar.dart' as sidebar;
import 'leave_page.dart';
import 'ltc_page.dart';
import 'CpdaAdvanceFormScreen.dart';
import 'CpdaClaim.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/profile.dart';
import '../../utils/home.dart';
import '../../utils/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleNavigation(int index) {
    if (index == 40) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recruitment module is under development'),
          duration: const Duration(seconds: 1),
        ),
      );
    } else if (index == 41) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LeaveFormScreen()),
      );
    } else if (index == 42) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LtcFormScreen()),
      );
    } else if (index == 43) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CpdaAdvanceFormScreen()),
      );
    } else if (index == 44) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CpdaClaimFormScreen()),
      );
    } else if (index == 45) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Appraisal module is under development'),
          duration: const Duration(seconds: 1),
        ),
      );
    } else if (index == 9) {
      // Navigate to Profile screen when selected from sidebar
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
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
      case 40:
        return 'Recruitment';
      case 41:
        return 'LEAVE Management';
      case 42:
        return 'LTC';
      case 43:
        return 'CPDA Advance';
      case 44:
        return 'CPDA Claim';
      case 45:
        return 'Appraisal';
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
          await Future.delayed(
              Duration.zero); // Add small delay to prevent navigation conflicts
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
        edgeWidthFactor: 1.0, // Allow swipe from anywhere on screen
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Human Resources',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                    physics:
                        const BouncingScrollPhysics(), // Added smooth scrolling
                    children: [
                      _buildDashboardCard(
                        icon: Icons.file_download_outlined,
                        label: 'LEAVE Management',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeaveFormScreen()),
                          );
                        },
                      ),
                      const SizedBox(
                          height: 16.0), // Consistent spacing between cards
                      _buildDashboardCard(
                        icon: Icons.flight,
                        label: 'LTC',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LtcFormScreen()),
                          );
                        },
                      ),
                      const SizedBox(
                          height: 16.0), // Consistent spacing between cards
                      _buildDashboardCard(
                        icon: Icons.article_outlined,
                        label: 'CPDA Advance',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CpdaAdvanceFormScreen()),
                          );
                        },
                      ),
                      const SizedBox(
                          height: 16.0), // Consistent spacing between cards
                      _buildDashboardCard(
                        icon: Icons.grid_4x4_outlined,
                        label: 'CPDA Claim',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CpdaClaimFormScreen()),
                          );
                        },
                      ),
                      const SizedBox(
                          height: 16.0), // Consistent spacing between cards
                      _buildDashboardCard(
                        icon: Icons.check_box_outlined,
                        label: 'Appraisal',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Appraisal module is under development'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BottomBar(
              currentIndex: 1), // Added BottomBar widget with HR module index
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 30.0,
                      color: cardColor,
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
