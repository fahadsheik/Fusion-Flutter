import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'purposepage.dart';

class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  String? leaveType;
  DateTime? fromDate;
  DateTime? toDate;
  PlatformFile? uploadedFile;

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        uploadedFile = result.files.first;
      });
    }
  }

  void _goToNextPage() {
    if (leaveType != null && fromDate != null && toDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PurposePage(
            leaveType: leaveType!,
            fromDate: fromDate!,
            toDate: toDate!,
            uploadedFile: uploadedFile,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        title:
            const Text("AKSHAY PAREWA", style: TextStyle(color: Colors.black)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("Leave Type *",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: leaveType,
              items: ["Sick Leave", "Casual Leave", "Emergency"]
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) => setState(() => leaveType = val),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Select",
              ),
            ),
            const SizedBox(height: 16),
            const Text("From *", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              onTap: () => _selectDate(context, true),
              decoration: InputDecoration(
                hintText: fromDate != null
                    ? fromDate.toString().split(" ")[0]
                    : "Click to select date",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, true),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("To *", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              onTap: () => _selectDate(context, false),
              decoration: InputDecoration(
                hintText: toDate != null
                    ? toDate.toString().split(" ")[0]
                    : "Click to select date",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, false),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Related Document",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.attach_file),
              label: Text(
                  uploadedFile != null ? uploadedFile!.name : "Choose file"),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Add any other leave type segment",
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _goToNextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text("NEXT", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
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
}
