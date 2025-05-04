import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import 'FileDetailsApproveReject.dart';

const Color kPrimaryBlue = Color(0xFF1E73BE);

class ApproveRequestsPage extends StatefulWidget {
  const ApproveRequestsPage({super.key});

  @override
  State<ApproveRequestsPage> createState() => _ApproveRequestsPageState();
}

class _ApproveRequestsPageState extends State<ApproveRequestsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> requests = [
    {
      "id": "8",
      "name": "req_1",
      "description": "req by dimw",
      "area": "Hostels",
      "createdBy": "dvijay",
    },
    {
      "id": "9",
      "name": "req_2",
      "description": "req by dimw",
      "area": "Library",
      "createdBy": "dvijay",
    },
    {
      "id": "10",
      "name": "req_3",
      "description": "req by dimw",
      "area": "Carticon",
      "createdBy": "dvijay",
    },
    {
      "id": "11",
      "name": "req_4",
      "description": "req by dimw",
      "area": "Labs",
      "createdBy": "dvijay",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) => handleGesture(details, _scaffoldKey),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Sidebar(),
        bottomNavigationBar: const BottomBar(),
        body: Column(
          children: [
            Container(
  decoration: const BoxDecoration(
    color: Color(0xF8F8F8), // Light background
  ),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_new, color: kPrimaryBlue),
      ),
      const Text(
        'Request Approvals',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: kPrimaryBlue,
          letterSpacing: 0.5,
        ),
      ),
      GestureDetector(
        onTap: () => _scaffoldKey.currentState?.openDrawer(),
        child: const Icon(Icons.menu, color: kPrimaryBlue),
      ),
    ],
  ),
),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow("ID:", request["id"]!),
                          _buildInfoRow("Name:", request["name"]!),
                          _buildInfoRow(
                              "Description:", request["description"]!),
                          _buildInfoRow("Area:", request["area"]!),
                          _buildInfoRow("Created By:", request["createdBy"]!),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.description, size: 18),
                              label: const Text("View File"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FileDetailsApproveReject(
                                      requestId: request["id"]!,
                                      requestName: request["name"]!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
