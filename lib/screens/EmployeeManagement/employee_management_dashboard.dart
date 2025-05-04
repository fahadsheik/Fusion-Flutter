import 'package:flutter/material.dart';
import 'publication_screen.dart'; // Add this import
import 'thesis_supervision_screen.dart'; // Add this import
import 'visits_screen.dart'; // Add this import
import 'conferences_screen.dart'; // Add this import
import 'projects_screen.dart'; // Add this import
import 'events_screen.dart'; // Add this import
import 'others_screen.dart'; // Add this import

class EmployeeManagementDashboard extends StatefulWidget {
  const EmployeeManagementDashboard({Key? key}) : super(key: key);

  @override
  State<EmployeeManagementDashboard> createState() =>
      _EmployeeManagementDashboardState();
}

class _EmployeeManagementDashboardState
    extends State<EmployeeManagementDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleNavigation(int index) {
    if (index == 0) {
      // Navigate to PublicationScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PublicationScreen()),
      );
    } else if (index == 1) {
      // Navigate to EventsScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EventsScreen()),
      );
    } else if (index == 2) {
      // Navigate to ThesisSupervisionScreen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ThesisSupervisionScreen()),
      );
    } else if (index == 3) {
      // Navigate to ProjectsScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectsScreen()),
      );
    } else if (index == 4) {
      // Navigate to VisitsScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VisitsScreen()),
      );
    } else if (index == 5) {
      // Navigate to ConferencesScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConferencesScreen()),
      );
    } else if (index == 6) { // Add this condition
      // Navigate to OthersScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OthersScreen()),
      );
    } else {
      // Handle other sections
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigating to section $index'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Employee Management'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDashboardCard(
              icon: Icons.article,
              label: 'Publications',
              onTap: () => _handleNavigation(0),
            ),
            const SizedBox(height: 16.0),
            _buildDashboardCard(
              icon: Icons.event_available, // Updated icon to match the image
              label: 'Events',
              onTap: () => _handleNavigation(1),
            ),
            const SizedBox(height: 16.0),
            _buildDashboardCard(
              icon: Icons.school,
              label: 'Thesis Supervision',
              onTap: () => _handleNavigation(2),
            ),
            const SizedBox(height: 16.0),
            _buildDashboardCard(
              icon: Icons.work,
              label: 'Projects',
              onTap: () => _handleNavigation(3),
            ),
            const SizedBox(height: 16.0),
            _buildDashboardCard(
              icon: Icons.travel_explore,
              label: 'Visits',
              onTap: () =>
                  _handleNavigation(4), // This index (4) matches the handler
            ),
            const SizedBox(height: 16.0),
            _buildDashboardCard(
              icon: Icons.forum, // Replace with a relevant icon for conferences
              label: 'Conferences', // Replace "Patents" with "Conferences"
              onTap: () => _handleNavigation(5),
            ),
            const SizedBox(height: 16.0),
            _buildDashboardCard(
              icon: Icons.more_horiz, // Icon for "Others"
              label: 'Others',
              onTap: () => _handleNavigation(6), // Add this card
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade500,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade200.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 30.0, color: Colors.blue.shade700),
              ),
              const SizedBox(width: 20.0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
