import 'package:flutter/material.dart';
import 'booking_form.dart';
import 'visitor_details_page.dart';
import 'current_booking.dart';
import 'cancel_booking.dart';
import 'completed_bookings.dart'; // NEW
import 'expenditure.dart'; // NEW

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  bool manageBookingsExpanded = true;
  bool messRecordExpanded = true;
  bool rulesExpanded = true;
  bool accountExpanded = true; // For Account Statement

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              // Profile Info
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage('assets/images/sindu_vakkurthy.png'),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Sindhu Vukkurthy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "MENU",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Divider(height: 30, thickness: 1),

              // Title
              Row(
                children: const [
                  Icon(Icons.menu, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "Visitor’s Hostel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Manage Bookings
              _buildExpandableSection(
                title: 'Manage Bookings',
                expanded: manageBookingsExpanded,
                onToggle: () {
                  setState(() {
                    manageBookingsExpanded = !manageBookingsExpanded;
                  });
                },
                children: [
                  _buildMenuItem(context, 'Booking request form', const BookingForm()),
                  _buildMenuItem(context, 'Visitor Details Form', VisitorDetailsPage()),
                  _buildPlainMenuItem('Bookings'),
                  _buildPlainMenuItem('Room Availability'),
                  _buildMenuItem(context, 'Current Bookings', const CurrentBookingsPage()),
                  _buildMenuItem(context, 'Cancel booking request', CancelBookingRequestPage()),
                  _buildMenuItem(context, 'Completed bookings', CompletedBookingsPage()), // UPDATED
                ],
              ),
              const SizedBox(height: 20),

              // Mess Record
              _buildExpandableSection(
                title: 'Mess Record',
                expanded: messRecordExpanded,
                onToggle: () {
                  setState(() {
                    messRecordExpanded = !messRecordExpanded;
                  });
                },
                children: [
                  _buildPlainMenuItem('Mess Menu'),
                  _buildPlainMenuItem('Book meal'),
                ],
              ),
              const SizedBox(height: 20),

              // Account Statement
              _buildExpandableSection(
                title: 'Account Statement',
                expanded: accountExpanded,
                onToggle: () {
                  setState(() {
                    accountExpanded = !accountExpanded;
                  });
                },
                children: [
                  _buildMenuItem(context, 'Total Statement', ExpenditurePage()), // UPDATED
                ],
              ),
              const SizedBox(height: 20),

              // Rules & Regulations
              _buildExpandableSection(
                title: 'Rules & Regulations',
                expanded: rulesExpanded,
                onToggle: () {
                  setState(() {
                    rulesExpanded = !rulesExpanded;
                  });
                },
                children: [
                  _buildPlainMenuItem('View Rules'),
                  _buildPlainMenuItem('Policy Info'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String text, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildPlainMenuItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool expanded,
    required VoidCallback onToggle,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.black,
              ),
            ],
          ),
        ),
        if (expanded)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
      ],
    );
  }
}
