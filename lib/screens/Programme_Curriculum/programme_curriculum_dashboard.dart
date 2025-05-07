import 'package:flutter/material.dart';
import '../../utils/sidebar.dart'
    as sidebar; // Import with alias to avoid class name conflicts
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import '../../utils/home.dart';
import 'programme_screen.dart';
import 'curriculum_screen.dart';
import 'discipline_screen.dart';
import 'batches_screen.dart'
    as batches_screen; // Import with alias to avoid conflicts
import 'courses_screen.dart'; // Import the new courses screen

class ProgrammeCurriculumDashboard extends StatefulWidget {
  const ProgrammeCurriculumDashboard({super.key});

  @override
  State<ProgrammeCurriculumDashboard> createState() =>
      _ProgrammeCurriculumDashboardState();
}

class _ProgrammeCurriculumDashboardState
    extends State<ProgrammeCurriculumDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleNavigation(int index) {
    if (index == 0) {
      // Already on dashboard
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProgrammeScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CurriculumScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CoursesScreen()),
      );
    } else if (index == 4) {
      // Navigate to the fully implemented BatchesScreen from batches_screen.dart
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const batches_screen.BatchesScreen(),
        ),
      );
    } else if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DisciplineScreen()),
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
        return 'Programme';
      case 2:
        return 'Curriculum';
      case 3:
        return 'Courses';
      case 4:
        return 'Batches';
      case 5:
        return 'Discipline';
      case 6:
        return 'Profile';
      case 7:
        return 'Settings';
      case 8:
        return 'Help';
      case 9:
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
              'Programmes & Curriculum',
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
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildDashboardCard(
                        icon: Icons.school,
                        label: 'Programme',
                        color: Colors.blue,
                        onTap: () => _handleNavigation(1),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.menu_book,
                        label: 'Curriculum',
                        color: Colors.blue,
                        onTap: () => _handleNavigation(2),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.book,
                        label: 'Courses',
                        color: Colors.blue,
                        onTap: () => _handleNavigation(3),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.people,
                        label: 'Batches',
                        color: Colors.blue,
                        onTap: () => _handleNavigation(4),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.account_tree,
                        label: 'Discipline',
                        color: Colors.blue,
                        onTap: () => _handleNavigation(5),
                      ),
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
    required Color color,
    required VoidCallback onTap,
  }) {
    // Using blue shade for all cards and icons
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

// Adding back a placeholder BatchesScreen for sidebar.dart to reference
// The actual implementation is in batches_screen.dart
class BatchesScreen extends StatelessWidget {
  const BatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This placeholder is needed for sidebar.dart to compile
    // The actual navigation logic is handled in _handleNavigation
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batches'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: const Center(
        child: Text('Loading Batches Screen...'),
      ),
    );
  }
}
