import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/profile.dart';
import '../../utils/home.dart';
import '../../utils/bottom_bar.dart';
import 'inventory_overview.dart';  // Import the new overview screen
import 'inventory_report_screen.dart'; // Import the report screen
import 'inventory_request_screen.dart'; // Import the request screen
import 'inventory_department_screen.dart'; // Import the department screen
import 'inventory_section_screen.dart'; // Import the section screen

class InventoryDashboard extends StatefulWidget {
  const InventoryDashboard({super.key});

  @override
  State<InventoryDashboard> createState() => _InventoryDashboardState();
}

class _InventoryDashboardState extends State<InventoryDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleNavigation(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InventoryHomeScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DepartmentScreen()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SectionScreen()),
      );
    } else if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ReportScreen()),
      );
    } else if (index == 6) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RequestScreen()),
      );
    } else if (index == 9) {
      // Navigate to home screen instead of Profile which might not exist
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
      case 0:
        return 'Dashboard';
      case 1:
        return 'Orders';
      case 2:
        return 'Home';
      case 3:
        return 'Department';
      case 4:
        return 'Section';
      case 5:
        return 'Report';
      case 6:
        return 'Request';
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
        edgeWidthFactor: 1.0, // Allow swipe from anywhere on screen
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Inventory Management',
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
          drawer: Sidebar(onItemSelected: _handleNavigation),
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
                    physics: const BouncingScrollPhysics(), // Added smooth scrolling
                    children: [
                      _buildDashboardCard(
                        icon: Icons.home,
                        label: 'Home',
                        color: Colors.orange,
                        onTap: () => _handleNavigation(2),
                      ),
                      const SizedBox(height: 16.0), // Consistent spacing between cards
                      _buildDashboardCard(
                        icon: Icons.business,
                        label: 'Department',
                        color: Colors.green,
                        onTap: () => _handleNavigation(3),
                      ),
                      const SizedBox(height: 16.0), // Consistent spacing between cards
                      _buildDashboardCard(
                        icon: Icons.category,
                        label: 'Section',
                        color: Colors.purple,
                        onTap: () => _handleNavigation(4),
                      ),
                      const SizedBox(height: 16.0), // Consistent spacing between cards
                      _buildDashboardCard(
                        icon: Icons.assessment,
                        label: 'Report',
                        color: Colors.blue,
                        onTap: () => _handleNavigation(5),
                      ),
                      const SizedBox(height: 16.0), // Consistent spacing between cards
                      _buildDashboardCard(
                        icon: Icons.receipt,
                        label: 'Request',
                        color: Colors.red,
                        onTap: () => _handleNavigation(6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BottomBar(), // Added BottomBar widget
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

// Placeholder classes for the screens that need to be implemented later
class InventoryHomeScreen extends StatelessWidget {
  const InventoryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InventoryOverviewScreen();
  }
}

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InventoryDepartmentScreen();
  }
}

class SectionScreen extends StatelessWidget {
  const SectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InventorySectionScreen();
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InventoryReportScreen();
  }
}

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InventoryRequestScreen();
  }
}