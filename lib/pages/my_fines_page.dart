import 'package:flutter/material.dart';

class MyFinesPage extends StatelessWidget {
  const MyFinesPage({super.key});

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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile & Menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/profile.png"),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Akshay Behl",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          const SizedBox(height: 20),

          // Top Navigation Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildNavButton("My Fines", Colors.blue, Colors.white),
                const SizedBox(width: 8),
                _buildNavButton(
                    "Request Guest-Room", Colors.white, Colors.blue),
                const SizedBox(width: 8),
                _buildNavButton("Room Allotment", Colors.white, Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Recent Fines Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Recent Fines",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("See All",
                  style: TextStyle(fontSize: 16, color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 10),

          // Scrollable Fine Cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFineCard("Late Entry", "25/01/2025"),
                const SizedBox(width: 10),
                _buildFineCard("Disciplinary Action", "25/01/2025"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Past Fines Section
          const Text("Past Fines",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _buildPastFine(
            title: "Over Disciplinary Issues",
            date: "09/09/2024",
            description:
                "Dear Student, fines are due. Ensure payment before the deadline to avoid further action.",
          ),
          _buildPastFine(
            title: "Littering inside Hostel",
            date: "06/08/2024",
            description:
                "Dear Student, fines are due. Ensure payment before the deadline to avoid further action.",
          ),
          _buildPastFine(
            title: "Electronic Gadgets",
            date: "07/01/2024",
            description:
                "Dear Student, fines are due. Ensure payment before the deadline to avoid further action.",
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Top Navigation Button
  Widget _buildNavButton(String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.blue),
        ),
      ),
      child: Text(text),
    );
  }

  // Fine Card
  Widget _buildFineCard(String title, String date) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, foregroundColor: Colors.white),
            child: const Text("Pay Now"),
          ),
          Text(date,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Past Fine Item
  Widget _buildPastFine(
      {required String title,
      required String date,
      required String description}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.circle, color: Colors.blue, size: 12),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Text(date, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return BottomAppBar(
      color: Colors.blue,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.home, color: Colors.white), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.book, color: Colors.white), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.person, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }
}
