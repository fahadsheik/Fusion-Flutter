import 'package:flutter/material.dart';
import 'viewdetails_2.dart'; // ✅ Make sure this import is here

class CancelBookingRequestPage extends StatelessWidget {
  const CancelBookingRequestPage({super.key});

  Widget bookingCard({
    required BuildContext context,
    required String name,
    required String dateRange,
    required String category,
    required String status,
    required Color statusColor,
    required String purpose,
    required String contact,
    required String email,
    required String address,
    required String payment,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Visitor's Name: $name",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          dateRange,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade100,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Room Category : $category",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check, size: 20),
            const SizedBox(width: 6),
            Text(
              "Status: $status",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewDetailsPage(
                      name: name,
                      dateRange: dateRange,
                      category: 'Category $category', // ✅ Updated here
                      purpose: purpose,
                      contact: contact,
                      email: email,
                      address: address,
                      payment: payment,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text("View details"),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text(status),
            ),
          ],
        ),
        const Divider(height: 40, thickness: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/sindu_vakkurthy.png'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(
              'Sindhu Vukkurthy',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
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
            const Center(
              child: Text(
                "Visitor’s Hostel",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Cancelled Bookings"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                "Cancel Booking Request",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            bookingCard(
              context: context,
              name: "Varshith",
              dateRange: "From 24 Jan 2025 to 28 Jan 2025",
              category: "A",
              status: "Pending",
              statusColor: Colors.orange,
              purpose: "Official Meeting",
              contact: "9876543210",
              email: "varshith@example.com",
              address: "Hyderabad, India",
              payment: "Paid via UPI",
            ),
            bookingCard(
              context: context,
              name: "Rishitha",
              dateRange: "From 19 Jan 2025 to 20 Jan 2025",
              category: "B",
              status: "Cancelled",
              statusColor: Colors.red,
              purpose: "Conference",
              contact: "9123456780",
              email: "rishitha@example.com",
              address: "Bangalore, India",
              payment: "Not Paid",
            ),
          ],
        ),
      ),
    );
  }
}
