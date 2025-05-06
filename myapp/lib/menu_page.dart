import 'package:flutter/material.dart';
import 'club.dart';
import 'clubs/Event.dart';
import 'clubs/Achievements.dart';
import 'fest.dart';
import 'clubs/register.dart';
import 'clubs/Members.dart';
import 'calender_page.dart';

class MenuPage extends StatelessWidget {
  final String userName;
  final String userRole;
  final String token;

  const MenuPage({
    super.key,
    required this.userName,
    required this.userRole,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  userName: userName,
                  userRole: userRole,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.blue,
              width: 10.0,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userRole,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Divider(thickness: 1),
                  ],
                ),
              ),
              _buildExpansionTile(
                icon: Icons.home,
                title: 'Home',
                children: [
                  _buildSubItem('View Clubs', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseClubPage(),
                      ),
                    );
                  }),
                  _buildSubItem('View Calendar', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarPage(),
                      ),
                    );
                  }),
                ],
              ),
              _buildExpansionTile(
                icon: Icons.group,
                title: 'Clubs',
                children: [
                  _buildSubItem('About'),
                  _buildSubItem('Members', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MembersPage(token: token),
                      ),
                    );
                  }),
                  _buildSubItem('Events', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EventsPage(),
                      ),
                    );
                  }),
                  _buildSubItem('Achievements', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AchievementsPage(),
                      ),
                    );
                  }),
                  _buildSubItem('Register', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  }),
                ],
              ),
              _buildExpansionTile(
                icon: Icons.event,
                title: 'Fests',
                children: [
                  _buildSubItem('List of Fests', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FestPage(),
                      ),
                    );
                  }),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.fitness_center),
                title: const Text('Gymkhana'),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile _buildExpansionTile({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      childrenPadding: const EdgeInsets.only(left: 40),
      children: children,
    );
  }

  ListTile _buildSubItem(String title, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(title),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      visualDensity: const VisualDensity(vertical: -4),
      onTap: onTap,
    );
  }
}

class ChooseClubPage extends StatefulWidget {
  const ChooseClubPage({super.key});

  @override
  State<ChooseClubPage> createState() => _ChooseClubPageState();
}

class _ChooseClubPageState extends State<ChooseClubPage> {
  final List<ClubCategory> categories = [
    ClubCategory(
      name: 'Technical',
      items: [
        ClubItem(name: 'Astronomy & Phy Society'),
        ClubItem(name: 'Aero Fabrication Club'),
        ClubItem(name: 'Business and Management Club'),
        ClubItem(name: 'CAD and 3D Printing Club'),
        ClubItem(name: 'Racing Club'),
        ClubItem(name: 'The Programming Club'),
        ClubItem(name: 'Electronics and Robotics Society'),
      ],
    ),
    ClubCategory(
      name: 'Cultural',
      items: [
        ClubItem(name: 'Avartan'),
        ClubItem(name: 'Samvadd'),
      ],
    ),
    ClubCategory(
      name: 'Sports',
      items: [
        ClubItem(name: 'Cricket'),
        ClubItem(name: 'Kabaddi'),
        ClubItem(name: 'Table Tennis'),
        ClubItem(name: 'Basket Ball'),
        ClubItem(name: 'Chess'),
        ClubItem(name: 'Badminton'),
      ],
    ),
  ];

  IconData _getIconForCategory(String categoryName) {
    switch (categoryName) {
      case 'Technical':
        return Icons.science;
      case 'Cultural':
        return Icons.palette;
      case 'Sports':
        return Icons.sports_soccer;
      default:
        return Icons.group;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubs'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.blue,
              width: 10.0,
            ),
          ),
        ),
        child: ListView(
          children: categories.map((category) {
            return ExpansionTile(
              title: Text(
                category.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              children: category.items.map((item) {
                return ListTile(
                  leading: Icon(
                    _getIconForCategory(category.name),
                    color: Colors.blue,
                    size: 28,
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  contentPadding: const EdgeInsets.only(left: 24.0),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userRole;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.blue,
              width: 10.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Role:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                userRole,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[700],
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Logout', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}























