import 'package:flutter/material.dart';
import '../../utils/sidebar.dart' as sidebar;
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import '../../main.dart';
import 'catalogue.dart';
import 'browse_applications.dart';
import 'application_status.dart';
import 'invite_applications.dart';
import 'catalogue_convenor.dart';
import 'application_status_convener.dart';
import '../../utils/home.dart';

class SpacsDashboard extends StatefulWidget {
  const SpacsDashboard({super.key});

  @override
  State<SpacsDashboard> createState() => _SpacsDashboardState();
}

class _SpacsDashboardState extends State<SpacsDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleNavigation(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CataloguePage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BrowseApplicationsPage()),
      );
    } else if (index == 4) {
      // Add navigation for Application Status
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ApplicationStatusPage()),
      );
    } else if (index == 5) {
      // Add navigation for Invite Applications
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InviteApplicationsPage()),
      );
    } else if (index == 6) {
      // Add navigation for Catalogue Convenor
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CatalogueConvenorPage()),
      );
    } else if (index == 7) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ApplicationStatusConvenerPage()),
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
      case 2:
        return 'Catalogue';
      case 3:
        return 'Browse Applications';
      case 4: // Add screen name for Application Status
        return 'Application Status';
      case 5: // Add screen name for Invite Applications
        return 'Invite Applications';
      case 6: 
        return 'Catalogue Convenor';
      case 7: 
        return 'Application Status (Convenor)';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'SPACS',
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
                    builder: (context) =>
                        const ExitConfirmationWrapper(child: HomeScreen()),
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
                      icon: Icons.book,
                      label: 'Catalogue',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CataloguePage()),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    _buildDashboardCard(
                      icon: Icons.folder_open,
                      label: 'Browse Applications',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BrowseApplicationsPage()),
                        );
                      },
                    ),
                    const SizedBox(
                        height: 16.0), // Add spacing for the new card
                    _buildDashboardCard(
                      icon: Icons.assignment, // Icon for Application Status
                      label: 'Application Status',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ApplicationStatusPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    _buildDashboardCard(
                      icon: Icons
                          .how_to_reg, // Updated icon for Invite Applications
                      label: 'Invite Applications',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const InviteApplicationsPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0), // Add spacing for the new card
                    _buildDashboardCard(
                      icon: Icons.edit_document, // Icon for Catalogue Convenor
                      label: 'Catalogue Convenor',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CatalogueConvenorPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    _buildDashboardCard(
                      icon: Icons.assignment_ind,
                      label: 'Application Status\n(Convener)', // Add a newline to split the text
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ApplicationStatusConvenerPage(),
                          ),
                        );
                      },
                      height: 120, // Increased height for the card
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    double height = 100, // Add a height parameter with a default value
  }) {
    Color cardColor = Colors.blue.shade700;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height, // Use the height parameter
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              cardColor,
              cardColor.withOpacity(0.7), // Fixed deprecated API usage
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.4), // Fixed deprecated API usage
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -15,
              child: Icon(
                icon,
                size: 100,
                color: Colors.white.withOpacity(0.15), // Fixed undefined identifier
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: cardColor.withOpacity(0.2), // Fixed deprecated API usage
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      size: 30.0,
                      color: cardColor,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded( // Ensure text wraps properly
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.7), // Fixed undefined identifier
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
