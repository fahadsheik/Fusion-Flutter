import 'package:flutter/material.dart';

class GuestRoomRequestPage extends StatelessWidget {
  const GuestRoomRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Student App",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile + Name + Menu Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.png'),
                        radius: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Akshay Behl",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: const Text("Menu",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Navigation Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _navTab(context, "Guest Room Allotment", true),
                    const SizedBox(width: 8),
                    _navTab(context, "Request Guest-Room", false),
                    const SizedBox(width: 8),
                    _navTab(context, "Room Allotment", false),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Active Request Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Active Request",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.pushNamed(context, '/guest-room-form');
                    },
                    child: const Text("ADD NEW",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Date: 09/03/2025",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    SizedBox(height: 4),
                    Text("Duration: 15-21/03/2025",
                        style: TextStyle(fontSize: 14)),
                    SizedBox(height: 4),
                    Text("Payment Status: Paid",
                        style: TextStyle(fontSize: 14, color: Colors.blue)),
                    SizedBox(height: 4),
                    Text("Additional Info: My parents would be staying",
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Past Requests Section
              const Text("Past Requests",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              _pastRequestTile("25-31/01/2025", "Paid", "Family Visit",
                  "Accepted", "21/01/2025"),
              _pastRequestTile("10-13/09/2024", "Not Paid", "Cousins Visiting",
                  "Rejected", "09/09/2024"),
              const SizedBox(height: 80), // Space for bottom nav bar
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.book, color: Colors.white), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white), label: ""),
        ],
      ),
    );
  }

  // Navigation Tab Widget
  Widget _navTab(BuildContext context, String title, bool isActive) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.white,
        side: const BorderSide(color: Colors.blue),
      ),
      onPressed: () {
        if (title == "Guest Room Allotment") {
          Navigator.pushNamed(context, '/guest-room');
        } else if (title == "Request Guest-Room") {
          Navigator.pushNamed(context, '/request-room');
        } else if (title == "Room Allotment") {
          Navigator.pushNamed(context, '/room-allotment');
        }
      },
      child: Text(title,
          style: TextStyle(color: isActive ? Colors.white : Colors.blue)),
    );
  }

  // Past Request Tile
  Widget _pastRequestTile(String date, String paymentStatus, String reason,
      String status, String appliedDate) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: status == "Accepted" ? Colors.lightBlue[100] : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(paymentStatus,
                  style: const TextStyle(fontSize: 14, color: Colors.blue)),
              const SizedBox(height: 4),
              Text(reason, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: status == "Accepted" ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              const SizedBox(height: 4),
              Text(appliedDate,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}
