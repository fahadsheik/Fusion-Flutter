import 'package:flutter/material.dart';
import 'package:excel/excel.dart' hide Border;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'academics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fusion Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const RollListPage(),
      routes: {
        '/module': (context) => const AcademicsModuleScreen(),
      }
    );
  }
}

class RollListPage extends StatelessWidget {
  const RollListPage({super.key});

  Future<void> _exportAsExcel(BuildContext context) async {
    // Request storage permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Create a new Excel document
      final excel = Excel.createExcel();
      final sheet = excel['Roll List'];
      
      // Add headers
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value = 'Roll No.';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value = 'Name';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value = 'Semester';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value = 'Branch';
      
      // Add data
      final data = [
        ['22BC5101', 'Avijit Biswas', '3', 'CSE'],
        ['22BC5019', 'Akash Kumar Sah', '3', 'CSE'],
        ['22BC5102', 'Suhani Srivastava', '3', 'CSE'],
        ['22BC5242', 'Suman Kumari', '3', 'CSE'],
        ['22BC5037', 'Anshraj Patikar', '3', 'CSE'],
        ['22BC5001', 'Utkarsh', '3', 'CSE'],
      ];
      
      for (int i = 0; i < data.length; i++) {
        for (int j = 0; j < data[i].length; j++) {
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1)).value = data[i][j];
        }
      }
      
      // Get the download directory
      final directory = await getExternalStorageDirectory();
      final path = '${directory!.path}/roll_list_OE2103.xlsx';
      
      // Save the Excel file
      final fileBytes = excel.save();
      if (fileBytes != null) {
        File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Excel file saved at: $path')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avijit Biswas',
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Acad Admin',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.search, color: Colors.blue[600]),
              const SizedBox(width: 16),
              Icon(Icons.notifications_none, color: Colors.blue[600]),
              const SizedBox(width: 8),
              Icon(Icons.more_vert, color: Colors.blue[600]),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: const Text(
              'Generate Roll List - OE2103',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                final students = [
                  ['22BC5101', 'Avijit Biswas', '3', 'CSE'],
                  ['22BC5019', 'Akash Kumar Sah', '3', 'CSE'],
                  ['22BC5102', 'Suhani Srivastava', '3', 'CSE'],
                  ['22BC5242', 'Suman Kumari', '3', 'CSE'],
                  ['22BC5037', 'Anshraj Patikar', '3', 'CSE'],
                  ['22BC5001', 'Utkarsh', '3', 'CSE'],
                ];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          students[index][0],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          students[index][1],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          students[index][2],
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          students[index][3],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _exportAsExcel(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue[600],
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.blue[600]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Export as Excel',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue[600],
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.blue[600]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.home, color: Colors.blue[600], size: 28),
                const Icon(Icons.menu_book_rounded, color: Colors.grey, size: 28),
                const Icon(Icons.search, color: Colors.grey, size: 28),
                const Icon(Icons.person_outline, color: Colors.grey, size: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
