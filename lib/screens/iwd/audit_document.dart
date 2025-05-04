import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import 'audit_viewfile.dart';

const Color kPrimaryBlue = Color(0xFF1E73BE);

class AuditDocumentsPage extends StatefulWidget {
  const AuditDocumentsPage({super.key});

  @override
  State<AuditDocumentsPage> createState() => _AuditDocumentsPageState();
}

class _AuditDocumentsPageState extends State<AuditDocumentsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> documents = [
    {"id": "8", "file": "req_1"},
    {"id": "9", "file": "req_2"},
    {"id": "10", "file": "req_3"},
    {"id": "11", "file": "req_4"},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Sidebar(),
        bottomNavigationBar: const BottomBar(),
        body: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: kPrimaryBlue),
                  ),
                  const Text(
                    'Audit Documents',
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
            // Table
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Table(
                  border: TableBorder.all(
                    color: Colors.grey.shade300,
                    width: 1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    // Table Header
                    TableRow(
                      decoration: BoxDecoration(
                        color: kPrimaryBlue.withOpacity(0.1),
                      ),
                      children: const [
                        _TableHeader(text: "ID"),
                        _TableHeader(text: "File"),
                        _TableHeader(text: "Actions"),
                      ],
                    ),
                    // Table Rows
                    ...documents.map(
                      (doc) => TableRow(
                        decoration: const BoxDecoration(color: Colors.white),
                        children: [
                          _TableCell(content: doc["id"]!),
                          _TableCell(content: doc["file"]!),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AuditViewFilePage(
                                    fileData: {
                                      'createdBy': 'dv@ay',
                                      'sentBy': 'dv@ay',
                                      'sentDate': '2025-02-18T23:55:28 72MPS',
                                      'receivedBy': '5424',
                                      'remarks':
                                          'File with id 627 created by dv@ay and sent to blue/models',
                                    },
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text("View File"),
                            ),
                          ),
                        ],
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

class _TableHeader extends StatelessWidget {
  final String text;
  const _TableHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String content;
  final TextStyle? textStyle;
  const _TableCell({required this.content, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        content,
        style: textStyle ?? const TextStyle(fontSize: 14),
      ),
    );
  }
}
