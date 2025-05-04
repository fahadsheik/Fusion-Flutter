import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import 'issue_work_order_form.dart';

class IssueWorkOrderPage extends StatefulWidget {
  const IssueWorkOrderPage({super.key});

  @override
  State<IssueWorkOrderPage> createState() => _IssueWorkOrderPageState();
}

class _IssueWorkOrderPageState extends State<IssueWorkOrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> workOrders = [
    {
      "id": "8",
      "name": "Leaking Pipe",
      "description": "Leakage in Hostel B2 bathroom",
      "area": "Hostels",
      "createdBy": "dvilay",
    },
    {
      "id": "7",
      "name": "Generator Noise",
      "description": "Loud noise from Power Generator",
      "area": "Power Generator",
      "createdBy": "rag123",
    },
    {
      "id": "6",
      "name": "AC Not Working",
      "description": "AC not cooling in Lecture Hall 2",
      "area": "Academic Block",
      "createdBy": "megha",
    },
    {
      "id": "5",
      "name": "Broken Light",
      "description": "Light not working in Staff Room",
      "area": "Admin Block",
      "createdBy": "ashwin",
    },
    {
      "id": "4",
      "name": "WiFi Issue",
      "description": "Slow internet in Hostel A1",
      "area": "Hostels",
      "createdBy": "pgupta",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) =>
          handleGesture(details, _scaffoldKey),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Sidebar(),
        bottomNavigationBar: const BottomBar(),
        body: Column(
          children: [
            // Header with background color
            Container(
              decoration: BoxDecoration(
  color: const Color(0xFFF8F8F8), // Correct 8-digit hex with opacity (FF)
  // borderRadius: const BorderRadius.only(
  //   bottomLeft: Radius.circular(16),
  //   bottomRight: Radius.circular(16),
  // ),
),

              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.blue),
                  ),
                  const Text(
                    'Work Order List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: const Icon(Icons.menu, color: Colors.blue),
                  ),
                ],
              ),
            ),
            // Work Order List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                itemCount: workOrders.length,
                itemBuilder: (context, index) {
                  final work = workOrders[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Work Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _infoRow("ID:", work["id"]!),
                        _infoRow("Name:", work["name"]!),
                        _infoRow("Description:", work["description"]!),
                        _infoRow("Area:", work["area"]!),
                        _infoRow("Created By:", work["createdBy"]!),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IssueWorkOrderForm(
                                    requestId: work["id"]!,
                                    requestName: work["name"]!,
                                  ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(color: Colors.blue),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            child: const Text("Issue Work Order"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label ",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              softWrap: true,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
