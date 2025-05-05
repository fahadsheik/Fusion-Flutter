import 'package:flutter/material.dart';
import 'menu.dart'; // For navigating back to menu
import 'viewdetails_2.dart'; // For navigating to view details

class CompletedBookingsPage extends StatelessWidget {
  const CompletedBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Avatar + Name + Menu
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SidebarMenu(),
                        ),
                      );
                    },
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

              const SizedBox(height: 12),

              // Tabs Row
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      elevation: 2,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Manage Bookings'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Completed Bookings'),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 18),
                ],
              ),

              const SizedBox(height: 30),
              const Text(
                "Completed Bookings",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Booking Cards
              buildBookingCard(
                context: context,
                bookingId: "#12345",
                name: "varshith",
                checkin: "01 Jan 2023",
                checkout: "05 Jan 2023",
              ),
              const SizedBox(height: 20),
              buildBookingCard(
                context: context,
                bookingId: "#67890",
                name: "varun",
                checkin: "01 Feb 2023",
                checkout: "05 Feb 2023",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookingCard({
    required BuildContext context,
    required String bookingId,
    required String name,
    required String checkin,
    required String checkout,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Booking ID: $bookingId",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 16)),

        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.cyanAccent.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "Check-in: $checkin - Check-out: $checkout",
            style: const TextStyle(fontSize: 14),
          ),
        ),

        const SizedBox(height: 16),

        // Buttons Row
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewDetailsPage(
                        name: name,
                        dateRange: "$checkin to $checkout",
                        category: "Category ‘A’",
                        purpose: "Casual visit",
                        contact: "9492110404",
                        email: "$name@gmail.com",
                        address: "Warangal, Telangana",
                        payment: "Offline",
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("View details"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add logic for rating stay
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Rate Your Stay"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
