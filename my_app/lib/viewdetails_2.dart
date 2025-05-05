import 'package:flutter/material.dart';
import 'menu.dart'; // ✅ Import the SidebarMenu

class ViewDetailsPage extends StatelessWidget {
  final String name;
  final String dateRange;
  final String category;
  final String purpose;
  final String contact;
  final String email;
  final String address;
  final String payment;

  const ViewDetailsPage({
    super.key,
    required this.name,
    required this.dateRange,
    required this.category,
    required this.purpose,
    required this.contact,
    required this.email,
    required this.address,
    required this.payment,
  });

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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SidebarMenu()),
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
              const SizedBox(height: 40),

              Text(
                "Intender name: $name",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              Text(
                dateRange,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
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
                child: Text(
                  category,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 24),

              InfoRow(label: "Purpose", value: purpose),
              InfoRow(label: "Contact Info", value: contact),
              InfoRow(label: "Email", value: email),
              InfoRow(label: "Address", value: address),
              InfoRow(label: "Payment", value: payment),

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
