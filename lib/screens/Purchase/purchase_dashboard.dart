import 'package:flutter/material.dart';
import 'PurchaseForm.dart';
import 'AllFiledIndents.dart';
import 'SavedIndents.dart';
import 'Inbox.dart';
import '../../utils/sidebar.dart' as sidebar;
import '../../utils/gesture_sidebar.dart';
import '../../utils/profile.dart';
import '../../utils/home.dart';
import '../../main.dart';

class PurchaseDashboard extends StatefulWidget {
  const PurchaseDashboard({super.key});

  @override
  State<PurchaseDashboard> createState() => _PurchaseDashboardState();
}

class _PurchaseDashboardState extends State<PurchaseDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleNavigation(int index) {
    switch (index) {
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PurchaseForm()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AllFiledIndents()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const InboxScreen()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedIndents()));
        break;
      case 9:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigating to ${_getScreenName(index)}')),
        );
    }
  }

  String _getScreenName(int index) {
    const screens = {
      0: 'Dashboard',
      1: 'Orders',
      2: 'Indent Form',
      3: 'All Filed Indents',
      4: 'Inbox',
      5: 'Saved Indents',
      9: 'Profile',
      10: 'Settings',
      11: 'Help',
      12: 'Log out',
    };
    return screens[index] ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ExitConfirmationWrapper(child: HomeScreen())),
                (route) => false,
          );
        }
      },
      child: GestureSidebar(
        scaffoldKey: _scaffoldKey,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Purchase', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue.shade700,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ExitConfirmationWrapper(child: HomeScreen())),
                      (route) => false,
                ),
              ),
            ],
          ),
          drawer: sidebar.Sidebar(onItemSelected: _handleNavigation),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(80)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildDashboardCard(
                        icon: Icons.description,
                        label: 'Indent Form',
                        onTap: () => _handleNavigation(2),
                      ),
                      _buildDashboardCard(
                        icon: Icons.list_alt,
                        label: 'All Filed Indents',
                        onTap: () => _handleNavigation(3),
                      ),
                      _buildDashboardCard(
                        icon: Icons.inbox,
                        label: 'Inbox',
                        onTap: () => _handleNavigation(4),
                      ),
                      _buildDashboardCard(
                        icon: Icons.save,
                        label: 'Saved Indents',
                        onTap: () => _handleNavigation(5),
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
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue.shade700),
              const SizedBox(height: 10),
              Text(label, style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              )),
            ],
          ),
        ),
      ),
    );
  }
}