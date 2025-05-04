import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import 'file_details_page.dart';

const Color kPrimaryBlue = Color(0xFF1E73BE);

class RequestStatusPage extends StatefulWidget {
  const RequestStatusPage({super.key});

  @override
  State<RequestStatusPage> createState() => _RequestStatusPageState();
}

class _RequestStatusPageState extends State<RequestStatusPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> requestData = [
  {
    "id": "8",
    "name": "req_1",
    "description": "req by dimw",
    "area": "Hostels",
    "createdBy": "dvilay",
    "status": "Work Completed",
  },
  {
    "id": "6",
    "name": "just",
    "description": "dfsijds",
    "area": "flnskjd",
    "createdBy": "dvilay",
    "status": "Rejected by the director",
  },
  {
    "id": "12",
    "name": "water_fix",
    "description": "Leaking pipe in lab area",
    "area": "Laboratories",
    "createdBy": "rshan",
    "status": "Pending Approval",
  },
  {
    "id": "15",
    "name": "light_issue",
    "description": "Hallway lights not working",
    "area": "Admin Block",
    "createdBy": "pkumar",
    "status": "Work Completed",
  },
];


  Color _getStatusColor(String status) {
    if (status == "Work Completed") return Colors.green.shade100;
    if (status == "Rejected by the director") return Colors.red.shade100;
    if (status == "Pending Approval") return Colors.orange.shade100;

    return Colors.grey.shade200;
  }

  Color _getStatusTextColor(String status) {
    if (status == "Work Completed") return Colors.green.shade800;
    if (status == "Rejected by the director") return Colors.red.shade800;
    return Colors.black87;
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            "$label:",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

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
                color: Color(0xF8F8F8), // Light blue background
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
                    'Request Status',
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
                itemCount: requestData.length,
                itemBuilder: (context, index) {
                  final data = requestData[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Request Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryBlue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildRow("ID", data["id"]!),
                          _buildRow("Name", data["name"]!),
                          _buildRow("Description", data["description"]!),
                          _buildRow("Area", data["area"]!),
                          _buildRow("Created By", data["createdBy"]!),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Status:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kPrimaryBlue,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(data["status"]!),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _getStatusTextColor(data["status"]!),
                                  ),
                                ),
                                child: Text(
                                  data["status"]!,
                                  style: TextStyle(
                                    color: _getStatusTextColor(data["status"]!),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 120,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FileDetailsPage(requestId: data["id"]!),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD0E5F7),
                                foregroundColor: kPrimaryBlue,
                                side: const BorderSide(
                                  color: kPrimaryBlue,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 2,
                              ),
                              child: const Text("View File"),
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
}
