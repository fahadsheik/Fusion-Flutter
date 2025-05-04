import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';

const Color kPrimaryBlue = Color(0xFF1E73BE);

class ViewBudgetPage extends StatefulWidget {
  const ViewBudgetPage({super.key});

  @override
  State<ViewBudgetPage> createState() => _ViewBudgetPageState();
}

class _ViewBudgetPageState extends State<ViewBudgetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
    final List<Map<String, String>> budgetData = [
    {"id": "1", "name": "Money", "budget": "₹200,000"},
    {"id": "2", "name": "Infrastructure", "budget": "₹500,000"},
    {"id": "3", "name": "Staff Salaries", "budget": "₹1,200,000"},
    {"id": "4", "name": "Maintenance", "budget": "₹150,000"},
    {"id": "5", "name": "IT Equipment", "budget": "₹750,000"},
    {"id": "6", "name": "Transportation", "budget": "₹300,000"},
    {"id": "7", "name": "Marketing", "budget": "₹450,000"},
    {"id": "8", "name": "Training", "budget": "₹200,000"},
    {"id": "9", "name": "Utilities", "budget": "₹180,000"},
    {"id": "10", "name": "Security", "budget": "₹250,000"},
    {"id": "11", "name": "Research", "budget": "₹600,000"},
    {"id": "12", "name": "Events", "budget": "₹350,000"},
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
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
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
                    'Budget Details',
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
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    // Table Header
                    TableRow(
                      decoration: BoxDecoration(
                        color: kPrimaryBlue.withOpacity(0.1),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Budget Issued',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // Table Rows
                    ...budgetData.map((budget) => TableRow(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                budget["id"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                budget["name"]!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                budget["budget"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        )),
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