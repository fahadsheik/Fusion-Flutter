import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';



class ViewProposalTablesPage extends StatefulWidget {
  const ViewProposalTablesPage({super.key});

  @override
  State<ViewProposalTablesPage> createState() => _ViewProposalTablesPageState();
}

class _ViewProposalTablesPageState extends State<ViewProposalTablesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> proposals = [
  {
    "id": 1,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-10T10:00:00",
    "createdAt": "2025-02-10T10:00:00",
    "status": "Pending",
    "fileId": "—",
    "budget": 10.00,
  },
  {
    "id": 2,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:19:26",
    "createdAt": "2025-02-11T17:19:26",
    "status": "Pending",
    "fileId": "—",
    "budget": 1.00,
  },
  {
    "id": 3,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:20:37",
    "createdAt": "2025-02-11T17:20:37",
    "status": "Rejected",
    "fileId": "—",
    "budget": 1.00,
  },
  {
    "id": 4,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:25:00",
    "createdAt": "2025-02-11T17:25:00",
    "status": "Approved",
    "fileId": "—",
    "budget": 5.50,
  },
  {
    "id": 5,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:28:00",
    "createdAt": "2025-02-11T17:28:00",
    "status": "Pending",
    "fileId": "—",
    "budget": 20.00,
  },
  {
    "id": 6,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:29:00",
    "createdAt": "2025-02-11T17:29:00",
    "status": "Rejected",
    "fileId": "—",
    "budget": 8.00,
  },
  {
    "id": 7,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:30:00",
    "createdAt": "2025-02-11T17:30:00",
    "status": "Approved",
    "fileId": "—",
    "budget": 50.00,
  },
  {
    "id": 8,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:31:00",
    "createdAt": "2025-02-11T17:31:00",
    "status": "Pending",
    "fileId": "—",
    "budget": 14.00,
  },
  {
    "id": 9,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:33:00",
    "createdAt": "2025-02-11T17:33:00",
    "status": "Rejected",
    "fileId": "—",
    "budget": 13.00,
  },
  {
    "id": 10,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:35:00",
    "createdAt": "2025-02-11T17:35:00",
    "status": "Approved",
    "fileId": "—",
    "budget": 99.99,
  },
  {
    "id": 11,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:36:00",
    "createdAt": "2025-02-11T17:36:00",
    "status": "Pending",
    "fileId": "—",
    "budget": 14.00,
  },
  {
    "id": 12,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:38:00",
    "createdAt": "2025-02-11T17:38:00",
    "status": "Rejected",
    "fileId": "—",
    "budget": 30.00,
  },
  {
    "id": 13,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:40:49",
    "createdAt": "2025-02-11T17:40:49",
    "status": "Approved",
    "fileId": "—",
    "budget": 120.00,
  },
  {
    "id": 14,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:42:00",
    "createdAt": "2025-02-11T17:42:00",
    "status": "Pending",
    "fileId": "—",
    "budget": 11.00,
  },
  {
    "id": 15,
    "createdBy": "dvijay",
    "lastUpdated": "2025-02-11T17:43:00",
    "createdAt": "2025-02-11T17:43:00",
    "status": "Approved",
    "fileId": "—",
    "budget": 7.00,
  },
];


  Color _getStatusColor(String status) {
    if (status == "Approved") return Colors.green.shade100;
    if (status == "Rejected") return Colors.red.shade100;
    if (status == "Pending") return Colors.orange.shade100;
    return Colors.grey.shade200;
  }

  Color _getStatusTextColor(String status) {
    if (status == "Approved") return Colors.green.shade800;
    if (status == "Rejected") return Colors.red.shade800;
    if (status == "Pending") return Colors.orange.shade800;
    return Colors.black87;
  }

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
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const Text(
                    'Proposal List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: const Icon(Icons.menu),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) =>
                          Colors.blue.withAlpha((0.1 * 255).toInt()),
                    ),
                    border: TableBorder.all(color: Colors.grey.shade300),
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Created By')),
                      DataColumn(label: Text('Last Updated')),
                      DataColumn(label: Text('Created At')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('File ID')),
                      DataColumn(label: Text('Budget')),
                    ],
                    rows: proposals.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(data['id'].toString())),
                          DataCell(Text(data['createdBy'])),
                          DataCell(Text(data['lastUpdated'])),
                          DataCell(Text(data['createdAt'])),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(data['status']),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                data['status'],
                                style: TextStyle(
                                  color: _getStatusTextColor(data['status']),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          DataCell(Text(data['fileId'].toString())),
                          DataCell(Text(data['budget'].toStringAsFixed(2))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
