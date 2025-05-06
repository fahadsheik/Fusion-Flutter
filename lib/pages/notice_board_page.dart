import 'package:flutter/material.dart';

class NoticeBoardPage extends StatelessWidget {
  const NoticeBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Akshay Behl",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
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
            const SizedBox(height: 25),

            // Navigation Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildNavButton("Notice Board", Colors.blue, Colors.white),
                  const SizedBox(width: 8),
                  _buildNavButton(
                      "Request Guest-Room", Colors.white, Colors.blue),
                  const SizedBox(width: 8),
                  _buildNavButton("Room Allotment", Colors.white, Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Notices Today
            const Text("Notices Today",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildNoticeTodayCard(
                "Hall-4 Canteen Not Available Today", "25/01/2025"),
            _buildNoticeTodayCard(
                "Warden Meeting Today at Hall-1", "8:00 - 9:00 PM"),
            const SizedBox(height: 30),

            // Past Notices
            const Text("Past Notices",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildPastNotice(
              title: "Warden Meeting",
              date: "09/09/2024",
              description:
                  "A meeting with the wardens is scheduled to discuss hostel management at Hall-2.",
            ),
            _buildPastNotice(
              title: "Saraswati Puja",
              date: "06/08/2024",
              description:
                  "Join us for the Saraswati Puja celebration at Hall 1 of our hostel.",
            ),
            _buildPastNotice(
              title: "Pongal Celebration",
              date: "07/01/2024",
              description:
                  "Join us for the Pongal celebration at Hall 1 of our hostel.",
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildNavButton(String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.blue),
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildNoticeTodayCard(String title, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(date,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPastNotice({
    required String title,
    required String date,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(date,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      color: Colors.blue,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.book, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {}),
        ],
      ),
    );
  }
}
