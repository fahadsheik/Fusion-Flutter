import 'package:flutter/material.dart';

class LeaveStatusPage extends StatefulWidget {
  const LeaveStatusPage({super.key});

  @override
  State<LeaveStatusPage> createState() => _LeaveStatusPageState();
}

class _LeaveStatusPageState extends State<LeaveStatusPage> {
  bool isOnlineSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
        ),
        title: const Text("Poojan", style: TextStyle(color: Colors.black)),
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const StadiumBorder(),
            ),
            child: const Text("MENU", style: TextStyle(color: Colors.white)),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Divider(thickness: 1, color: Colors.blue),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ToggleButtons(
              isSelected: [isOnlineSelected, !isOnlineSelected],
              onPressed: (index) {
                setState(() {
                  isOnlineSelected = index == 0;
                });
              },
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.blue,
              color: Colors.black,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Online"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Offline"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              columnWidths: const {
                0: FlexColumnWidth(1.2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("S.No.", textAlign: TextAlign.center),
                      ),
                    ),
                    for (int i = 3; i >= 1; i++)
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child:
                              Text(i.toString(), textAlign: TextAlign.center),
                        ),
                      ),
                  ],
                ),
                _buildTableRow("Applied At", ["-", "-", "-"]),
                _buildTableRow("Details", ["-", "-", "-"]),
                _buildTableRow("Status", ["-", "-", "-"]),
                _buildTableRow("Delete", ["-", "-", "-"]),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text("Approved:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Icon(Icons.check, color: Colors.green),
                ],
              ),
              Row(
                children: [
                  Text("Pending:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Icon(Icons.hourglass_empty, color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  Text("Declined:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Icon(Icons.close, color: Colors.red),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String title, List<String> values) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(title, textAlign: TextAlign.center),
          ),
        ),
        ...values.map(
          (value) => TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(value, textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    );
  }
}
