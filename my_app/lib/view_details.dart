import 'package:flutter/material.dart';
import 'current_booking.dart'; // Correct import for currentbookings.dart

class ViewDetailsPage extends StatelessWidget {
  const ViewDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile + Menu Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            AssetImage('assets/images/sindu_vakkurthy.png'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sindhu Vukkurthy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('MENU'),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Text(
                "Visitor’s Hostel",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),

              const Text(
                "Intender name: Sindhu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              const Text(
                "From 18 Jan 2025 to 21 Jan 2025",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Category
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "Category ‘A’",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 24),

              const InfoRow(label: "Purpose", value: "Casual visit"),
              const InfoRow(label: "Contact Info", value: "9492110404"),
              const InfoRow(label: "Email", value: "sindhu@gmail.com"),
              const InfoRow(label: "Address", value: "Warangal, Telangana"),
              const InfoRow(label: "Payment", value: "Offline"),

              const SizedBox(height: 24),

              // Status
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.hourglass_empty),
                    SizedBox(width: 10),
                    Text(
                      "Status: Pending",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to CurrentBookingsPage when Cancel is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CurrentBookingsPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Help"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text(label, style: const TextStyle(fontSize: 16))),
          const Text(": "),
          Expanded(
            flex: 4,
            child: Text(value,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
