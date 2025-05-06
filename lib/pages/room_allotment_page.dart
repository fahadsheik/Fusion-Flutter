import 'package:flutter/material.dart';

class RoomAllotmentPage extends StatelessWidget {
  const RoomAllotmentPage({super.key});

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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                  _buildNavButton(context, "Room Allotment", true),
                  const SizedBox(width: 8),
                  _buildNavButton(context, "Request Guest-Room", false),
                  const SizedBox(width: 8),
                  _buildNavButton(context, "Register Complaint", false),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Room Allotments Section
            const Text("Room Allotments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Roll Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                  ),
                  child: const Text("Search"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Room Allotment Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.blue[50]),
                columns: const [
                  DataColumn(label: Text("Student Name")),
                  DataColumn(label: Text("Roll Number")),
                  DataColumn(label: Text("Room Number")),
                  DataColumn(label: Text("Hall")),
                ],
                rows: [
                  _dataRow("Akshay Behl", "22BEC009", "A-109", "Hall-1"),
                  _dataRow("Akshay Behl", "22BEC009", "A-108", "Hall-1"),
                  _dataRow("Akshay Behl", "22BEC009", "B-109", "Hall-1"),
                  _dataRow("Akshay Behl", "22BEC009", "C-124", "Hall-1"),
                  _dataRow("Akshay Behl", "22BEC009", "A-006", "Hall-1"),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Past Allotments
            const Text("Past Allotments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _pastAllotmentTile("Hostel-1", "01/01/2023", "01/06/2023"),
            _pastAllotmentTile("Hostel-2", "01/07/2023", "31/12/2023"),
            _pastAllotmentTile("Hostel-3", "01/01/2024", "Present"),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildNavButton(BuildContext context, String text, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        if (text == "Register Complaint") {
          Navigator.pushNamed(context, '/complaints');
        } else if (text == "Request Guest-Room") {
          Navigator.pushNamed(context, '/request-guest-room');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.blue),
        ),
      ),
      child: Text(text),
    );
  }

  DataRow _dataRow(String name, String roll, String room, String hall) {
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(roll)),
      DataCell(Text(room)),
      DataCell(Text(hall)),
    ]);
  }

  Widget _pastAllotmentTile(String hostel, String fromDate, String toDate) {
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
          Text(hostel,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Text("From: $fromDate   To: $toDate",
              style: const TextStyle(color: Colors.black87, fontSize: 14)),
        ],
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
