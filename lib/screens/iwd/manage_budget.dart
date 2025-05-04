import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import 'edit_budget.dart';
import 'add_budget.dart';

const Color kPrimaryBlue = Color(0xFF1E73BE);

class ManageBudgetPage extends StatefulWidget {
  const ManageBudgetPage({super.key});

  @override
  State<ManageBudgetPage> createState() => _ManageBudgetPageState();
}

class _ManageBudgetPageState extends State<ManageBudgetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> budgetData = [
    {"id": "1", "name": "Money", "budget": "₹2,00,000"},
    {"id": "9", "name": "req_2", "budget": "₹2,55,000"},
    {"id": "10", "name": "req_3", "budget": "₹30,000"},
    {"id": "11", "name": "req_4", "budget": "₹4,000"},
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
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: kPrimaryBlue),
                  ),
                  const Text(
                    'Manage Budget',
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
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                        width: 1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(1.5),
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
                            _TableHeader(text: "ID"),
                            _TableHeader(text: "Name"),
                            _TableHeader(text: "Budget Issued"),
                            _TableHeader(text: "Actions"),
                          ],
                        ),
                        // Table Rows
                        ...budgetData.map((budget) => TableRow(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              children: [
                                _TableCell(content: budget["id"]!),
                                _TableCell(content: budget["name"]!),
                                _TableCell(
                                  content: budget["budget"]!,
                                  textStyle: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    onPressed: () async {
  final updatedBudget = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditBudgetPage(budget: budget),
    ),
  );

  if (updatedBudget != null) {
    setState(() {
      int index = budgetData.indexWhere((b) => b['id'] == updatedBudget['id']);
      if (index != -1) {
        budgetData[index] = updatedBudget;
      }
    });
  }
},

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryBlue,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text("Edit"),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text("Add Budget"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          final newBudget = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddBudgetPage()),
                          );

                          if (newBudget != null) {
                            setState(() {
                              budgetData.add(newBudget as Map<String, String>);
                            });
                          }
                        },
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
