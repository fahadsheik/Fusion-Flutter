import 'package:flutter/material.dart';
import 'view_details.dart'; // Make sure this import path is correct
import 'menu.dart'; // Import SidebarMenu (MenuPage)

class CurrentBookingsPage extends StatelessWidget {
  const CurrentBookingsPage({super.key});

  Widget bookingCard({
    required BuildContext context,
    required String name,
    required String dateRange,
    required String category,
    required String status,
    required VoidCallback onViewDetails,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Intender name: $name",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(dateRange,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text("Category ‘$category’",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.check, size: 20),
              const SizedBox(width: 8),
              Text("Status: $status",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: onViewDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("View details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          const Divider(height: 40, thickness: 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/sindu_vakkurthy.png'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(
              'Sindhu Vukkurthy',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Navigate to SidebarMenu (MenuPage)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SidebarMenu()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text("MENU"),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("Visitor’s Hostel",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Manage Bookings"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    "Booking Form",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            const SizedBox(height: 20),

            // Booking 1 - Sindhu (links to details page)
            bookingCard(
              context: context,
              name: "Sindhu",
              dateRange: "From 18 Jan 2025 to 21 Jan 2025",
              category: "A",
              status: "Pending",
              onViewDetails: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewDetailsPage(),
                  ),
                );
              },
            ),

            // Booking 2 - Varshith
            bookingCard(
              context: context,
              name: "Varshith",
              dateRange: "From 24 Jan 2025 to 28 Jan 2025",
              category: "C",
              status: "Cancelled",
              onViewDetails: () {}, // no navigation
            ),

            // Booking 3 - Rishitha
            bookingCard(
              context: context,
              name: "Rishitha",
              dateRange: "From 19 Jan 2025 to 20 Jan 2025",
              category: "B",
              status: "Confirmed",
              onViewDetails: () {}, // no navigation
            ),
          ],
        ),
      ),
    );
  }
}
