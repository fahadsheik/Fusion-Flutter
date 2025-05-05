import 'package:flutter/material.dart';

class LeaveStatusPage extends StatelessWidget {
  const LeaveStatusPage({super.key});

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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
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

              // Top Navigation Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _navTab(context, "Leave Status", true),
                    const SizedBox(width: 8),
                    _navTab(context, "Request Guest-Room", false),
                    const SizedBox(width: 8),
                    _navTab(context, "Room Alotment", false),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Current Leave Request Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Current Leave Request",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("ADD NEW",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              _leaveCard(
                fromDate: "28 Feb,2025",
                toDate: "5 March,2025",
                description:
                    "Requesting leave for attending a cultural event one of the renowned institutes.",
                status: "Pending",
                appliedOn: "09/02/2025",
                isCurrent: true,
              ),

              const SizedBox(height: 20),
              const Text("Past Request",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              _leaveCard(
                fromDate: "28 Feb,2024",
                toDate: "5 March,2024",
                description:
                    "Requesting leave for attending a family event in my hometown.",
                status: "Accepted",
                appliedOn: "09/02/2024",
              ),
              _leaveCard(
                fromDate: "28 March,2024",
                toDate: "30 March,2024",
                description:
                    "Requesting leave for attending hackathon one of the renowned institutes.",
                status: "Rejected",
                appliedOn: "09/02/2024",
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
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
        if (title == "Room Allotment") {
          Navigator.pushNamed(context, '/room-allotment');
        } else if (title == "Request Guest-Room") {
          Navigator.pushNamed(context, '/request-room');
        } else if (title == "Leave Status") {
          Navigator.pushNamed(context, '/leave-status');
        }
      },
      child: Text(title,
          style: TextStyle(color: isActive ? Colors.white : Colors.blue)),
    );
  }

  // Leave Card Widget
  Widget _leaveCard({
    required String fromDate,
    required String toDate,
    required String description,
    required String status,
    required String appliedOn,
    bool isCurrent = false,
  }) {
    final statusColor = status == "Accepted"
        ? Colors.blue
        : status == "Rejected"
            ? Colors.grey
            : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrent
            ? Colors.lightBlue[100]
            : status == "Accepted"
                ? Colors.lightBlue[100]
                : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("$fromDate to $toDate",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black)),
        const SizedBox(height: 4),
        Text("Description : $description",
            style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: statusColor,
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
            Text(appliedOn,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ]),
    );
  }
}
