import 'package:flutter/material.dart';

// Base curriculum page widget that can be customized for different departments
class CurriculumPage extends StatelessWidget {
  final String title;
  final List<String> semesters;
  final List<String> startDates;
  final List<String> endDates;
  final List<String> totalCredits;
  final List<String> instigatedStatus;

  const CurriculumPage({
    Key? key,
    required this.title,
    required this.semesters,
    this.startDates = const [],
    this.endDates = const [],
    this.totalCredits = const [],
    this.instigatedStatus = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use default values if not provided
    final effectiveStartDates =
        startDates.isEmpty ? semesters.map((_) => "N/A").toList() : startDates;

    final effectiveEndDates =
        endDates.isEmpty ? semesters.map((_) => "N/A").toList() : endDates;

    final effectiveTotalCredits = totalCredits.isEmpty
        ? semesters.map((_) => "0").toList()
        : totalCredits;

    final effectiveInstigated = instigatedStatus.isEmpty
        ? semesters.map((_) => "Not Yet").toList()
        : instigatedStatus;

    return Scaffold(
      appBar: AppBar(
        title: Text("$title Table"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Table(
                  defaultColumnWidth: const FixedColumnWidth(120.0),
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    // Header Row: Semesters
                    TableRow(
                      children: [
                        const TableCell(child: SizedBox()),
                        ...semesters.map((sem) => Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.grey.shade200,
                              child: Center(
                                child: Text(
                                  sem,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    // Start Date Row
                    _buildRow("Start Date", effectiveStartDates),
                    // End Date Row
                    _buildRow("End Date", effectiveEndDates),
                    // Total Credits Row
                    _buildRow("Total Credits", effectiveTotalCredits),
                    // Instigated Row
                    _buildRow("Instigated", effectiveInstigated, isRed: true),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildRow(String label, List<String> values, {bool isRed = false}) {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey.shade300,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: label == "Instigated" ? Colors.black : Colors.blue,
            ),
          ),
        ),
        ...values.map((val) => Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                val,
                style: TextStyle(
                  color: isRed
                      ? (val == "Yes" ? Colors.green : Colors.red)
                      : Colors.black,
                  fontWeight: isRed ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            )),
      ],
    );
  }
}

// ME PhD Curriculum Page
class MePhdCurriculumPage extends StatelessWidget {
  const MePhdCurriculumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> semesters = [
      "Semester 1",
      "Semester 2",
      "Semester 3",
      "Semester 4"
    ];

    return const CurriculumPage(
      title: "ME PhD Curriculum",
      semesters: semesters,
    );
  }
}

// CSE PhD Curriculum Page
class CsePhdCurriculumPage extends StatelessWidget {
  const CsePhdCurriculumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> semesters = [
      "Semester 1",
      "Semester 2",
      "Semester 3",
      "Semester 4"
    ];

    return const CurriculumPage(
      title: "CSE PhD Curriculum",
      semesters: semesters,
    );
  }
}

// ME UG Curriculum Page
class MeUgCurriculumPage extends StatelessWidget {
  const MeUgCurriculumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> semesters = [
      "Semester 1",
      "Semester 2",
      "Semester 3",
      "Semester 4",
      "Semester 5",
      "Semester 6",
      "Semester 7",
      "Semester 8"
    ];

    return CurriculumPage(
      title: "ME UG Curriculum",
      semesters: semesters,
      startDates: const [
        "01/08/2023",
        "01/01/2024",
        "01/08/2024",
        "01/01/2025",
        "01/08/2025",
        "01/01/2026",
        "01/08/2026",
        "01/01/2027"
      ],
      endDates: const [
        "31/12/2023",
        "31/05/2024",
        "31/12/2024",
        "31/05/2025",
        "31/12/2025",
        "31/05/2026",
        "31/12/2026",
        "31/05/2027"
      ],
      totalCredits: const ["20", "22", "24", "20", "24", "20", "18", "16"],
      instigatedStatus: const [
        "Yes",
        "Yes",
        "Not Yet",
        "Not Yet",
        "Not Yet",
        "Not Yet",
        "Not Yet",
        "Not Yet"
      ],
    );
  }
}

// ECE PhD Curriculum Page
class EcePhdCurriculumPage extends StatelessWidget {
  const EcePhdCurriculumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> semesters = [
      "Semester 1",
      "Semester 2",
      "Semester 3",
      "Semester 4"
    ];

    return CurriculumPage(
      title: "ECE PhD Curriculum",
      semesters: semesters,
      startDates: const [
        "01/08/2023",
        "01/01/2024",
        "01/08/2024",
        "01/01/2025"
      ],
      endDates: const ["31/12/2023", "31/05/2024", "31/12/2024", "31/05/2025"],
      totalCredits: const ["16", "18", "15", "12"],
      instigatedStatus: const ["Yes", "Not Yet", "Not Yet", "Not Yet"],
    );
  }
}

// Maths PhD Curriculum Page
class MathsPhdCurriculumPage extends StatelessWidget {
  const MathsPhdCurriculumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> semesters = [
      "Semester 1",
      "Semester 2",
      "Semester 3",
      "Semester 4"
    ];

    return CurriculumPage(
      title: "PhD Natural Sciences (Maths) Curriculum",
      semesters: semesters,
      startDates: const [
        "01/08/2023",
        "01/01/2024",
        "01/08/2024",
        "01/01/2025"
      ],
      endDates: const ["31/12/2023", "31/05/2024", "31/12/2024", "31/05/2025"],
      totalCredits: const ["14", "16", "12", "10"],
      instigatedStatus: const ["Yes", "Yes", "Not Yet", "Not Yet"],
    );
  }
}
