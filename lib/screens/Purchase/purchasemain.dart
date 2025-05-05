import 'package:flutter/material.dart';
import 'PurchaseForm.dart';
import 'AllFiledIndents.dart';
import 'SavedIndents.dart';
import 'Inbox.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/profile.dart';
import '../../utils/home.dart';
import '../../main.dart';

class PurchaseMainScreen extends StatefulWidget {
  const PurchaseMainScreen({super.key});

  @override
  State<PurchaseMainScreen> createState() => _PurchaseMainScreenState();
}

class _PurchaseMainScreenState extends State<PurchaseMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleNavigation(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PurchaseForm()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AllFiledIndents()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InboxScreen()),
      );
    } else if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SavedIndents()),
      );
    } else if (index == 9) {
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
      case 0:
        return 'Dashboard';
      case 1:
        return 'Orders';
      case 2:
        return 'Indent Form';
      case 3:
        return 'All Filed';
      case 4:
        return 'Inbox';
      case 5:
        return 'Saved Indents';
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
      onPopInvoked: (didPop) {
        if (didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const ExitConfirmationWrapper(child: HomeScreen()),
            ),
                (route) => false,
          );
        }
      },
      child: GestureSidebar(
        scaffoldKey: _scaffoldKey,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Purchase',
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
                  left: 20.0,
                  right: 20.0,
                  bottom: 6.0,
                  top: 10.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      _buildDashboardCard(
                        icon: Icons.description,
                        label: 'Indent Form',
                        onTap: () => _handleNavigation(2),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.list_alt,
                        label: 'All Filed',
                        onTap: () => _handleNavigation(3),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDashboardCard(
                        icon: Icons.inbox,
                        label: 'Inbox',
                        onTap: () => _handleNavigation(4),
                      ),
                      const SizedBox(height: 16.0),
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
    Color cardColor = Colors.blue.shade700;

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
            Positioned(
              right: -15,
              bottom: -15,
              child: Icon(
                icon,
                size: 100,
                color: Colors.white.withOpacity(0.15),
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
                          color: cardColor.withOpacity(0.2),
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
// import 'package:flutter/material.dart';
// import 'PurchaseForm.dart';
// import 'AllFiledIndents.dart';
// import 'SavedIndents.dart';
// import 'Inbox.dart';
// import '../../utils/sidebar.dart';
//
// class PurchaseMainScreen extends StatefulWidget {
//   final int initialTab;
//
//   const PurchaseMainScreen({super.key, this.initialTab = 0});
//
//   @override
//   State<PurchaseMainScreen> createState() => _PurchaseMainScreenState();
// }
//
// class _PurchaseMainScreenState extends State<PurchaseMainScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   late int selectedIndex;
//
//   final List<Widget> screens = [
//     const PurchaseForm(),
//     const AllFiledIndents(),
//     const InboxScreen(),       // ✅ Added Inbox screen here
//     const SavedIndents(),
//   ];
//
//   final List<String> tabs = [
//     "Indent Form",
//     "All Filed",
//     "Inbox",                  // ✅ Added Inbox tab here
//     "Saved Indents",
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = widget.initialTab;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: const Sidebar(),
//       appBar: AppBar(
//         title: const Text(
//           'Purchase',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.blue.shade700,
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Colors.white),
//           onPressed: () => _scaffoldKey.currentState!.openDrawer(),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications, color: Colors.white),
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text("No new notifications"),
//                   duration: Duration(seconds: 1),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.blue.shade700,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(80),
//                 bottomRight: Radius.circular(80),
//               ),
//             ),
//             padding: const EdgeInsets.only(
//               left: 20.0,
//               right: 20.0,
//               bottom: 16.0,
//               top: 12.0,
//             ),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(
//                   tabs.length,
//                       (index) => _buildNavButton(tabs[index], index),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: screens[selectedIndex],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavButton(String text, int index) {
//     final bool isSelected = selectedIndex == index;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Colors.blue.shade600,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Text(
//             text,
//             style: TextStyle(
//               color: isSelected ? Colors.blue.shade700 : Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

