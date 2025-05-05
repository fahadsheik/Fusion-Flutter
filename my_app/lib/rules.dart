import 'package:flutter/material.dart';
import 'menu.dart'; // Import the menu page here

class RulesGuidelinesPage extends StatelessWidget {
  final List<String> rules = [
    "1. For booking of normal facilities, duly filled in forms/e-forms, may directly be submitted to Incharge VH through email/in hard copy.",
    "2. The bookings are purely provisional and subject to availability.",
    "3. Priority will be given to Institute guests, visitors coming for academic activities.",
    "4. Personal bookings (10% of total rooms) will be made on the basis of availability.",
    "5. Such bookings will be provisional and will be confirmed only 3 days before arrival.",
    "6. Students may be allotted accommodation in VH for their PARENTS/SPOUSE if rooms unavailable in hostels.",
    "7. Telephonic bookings/cancellations will not be entertained unless it's an emergency.",
    "8. Confirmation/non-acceptance will be communicated via email within 24 hours.",
    "9. Rooms may be shared with other guests if needed.",
    "10. Guests of category C may stay up to 5 (Five) days only."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar (Blue vertical bar)
            Container(
              width: 60,
              color: Colors.blue.shade100,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Update the Icon to navigate to MenuPage on tap
                  IconButton(
                    icon: Icon(Icons.menu, size: 28, color: Colors.black87),
                    onPressed: () {
                      // Navigate to the MenuPage when the menu icon is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SidebarMenu()),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  Icon(Icons.search_rounded, size: 26, color: Colors.black54),
                  SizedBox(height: 20),
                  Icon(Icons.computer_rounded, size: 26, color: Colors.black54),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Profile + Title + Menu
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/sindu_vakkurthy.png'),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sindhu Vukkurthy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[800],
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to SidebarMenu when the MENU button is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SidebarMenu()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: Text('MENU'),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Divider(color: Colors.blue, thickness: 4),

                    // Visitor’s Hostel Title
                    Text(
                      "Visitor’s Hostel",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 20),

                    // Norms & Guidelines Heading
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Norms & Guidelines",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Rules Container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: rules
                            .map((rule) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    rule,
                                    style: TextStyle(fontSize: 15, height: 1.4),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
