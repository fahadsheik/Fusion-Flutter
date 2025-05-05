import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fusion App"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        "assets/profile.png"), // Replace with actual image path
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Akshay Behl",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hostel Management",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {},
                  child:
                      const Text("Menu", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildExpandableTile(
                "View Allotted Room", context, "/allottedRoom"),
            _buildExpandableTile("Guest Room", context, "/guestRoom"),
            _buildExpandableTile("Complaints", context, "/complaints"),
            _buildExpandableTile("Notice Board", context, "/noticeBoard"),
            _buildExpandableTile("View Fines", context, "/fines"),
            _buildExpandableTile("Leaves", context, "/leaves"),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableTile(
      String title, BuildContext context, String route) {
    return ExpansionTile(
      title: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      children: [
        ListTile(
          title: const Text("Check status"),
          onTap: () {
            Navigator.pushNamed(context, route);
          },
        ),
      ],
    );
  }
}
