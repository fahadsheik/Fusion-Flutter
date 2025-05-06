import 'package:flutter/material.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

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
        padding: const EdgeInsets.all(16),
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
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
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

          // Horizontal Nav Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildNavButton("Register Complaint", isSelected: true),
                const SizedBox(width: 8),
                _buildNavButton("Request Guest-Room"),
                const SizedBox(width: 8),
                _buildNavButton("Room Allotment"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Active Complaint Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Active Complaint",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                child: const Text("ADD NEW"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildActiveComplaintCard(),
          const SizedBox(height: 20),

          const Text(
            "Past Complaints",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ..._buildPastComplaintCards(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavButton(String text, {bool isSelected = false}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.blue),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  Widget _buildActiveComplaintCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Label: Water Supply",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          SizedBox(height: 5),
          Text("Date: 08/03/2025",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          SizedBox(height: 5),
          Text("Location: Vashishta Hostel",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          SizedBox(height: 5),
          Text(
            "Description: No water supply in Block A from 2 days",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPastComplaintCards() {
    List<Map<String, String>> complaints = [
      {
        "label": "Inventory",
        "description": "No chair provided in Room A204",
        "date": "09/09/2024"
      },
      {
        "label": "Maintenance",
        "description": "Bathroom lights not working in B Block",
        "date": "05/07/2024"
      },
    ];

    return complaints.asMap().entries.map((entry) {
      int index = entry.key;
      var complaint = entry.value;
      return _buildPastComplaintCard(
        complaint["label"]!,
        complaint["description"]!,
        complaint["date"]!,
        index.isEven ? Colors.blue.shade100 : Colors.grey.shade300,
      );
    }).toList();
  }

  Widget _buildPastComplaintCard(
      String label, String description, String date, Color bgColor) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: bgColor,
      child: ListTile(
        leading: const Icon(Icons.circle, color: Colors.blue, size: 12),
        title: Text("Label: $label",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text("RESOLVED",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            const SizedBox(height: 5),
            Text(date, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.blue,
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
