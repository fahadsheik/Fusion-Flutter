import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PurposePage extends StatefulWidget {
  final String leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final PlatformFile? uploadedFile;

  const PurposePage({
    super.key,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    this.uploadedFile,
  });

  @override
  State<PurposePage> createState() => _PurposePageState();
}

class _PurposePageState extends State<PurposePage> {
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // You can handle the form data here if needed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Leave application submitted")),
      );

      // Optionally clear fields
      _purposeController.clear();
      _infoController.clear();
    }
  }

  @override
  void dispose() {
    _purposeController.dispose();
    _infoController.dispose();
    super.dispose();
  }

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
        title: const Text("AKSHAY PAREWA", style: TextStyle(color: Colors.black)),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Leave Type: ${widget.leaveType}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("From Date: ${widget.fromDate.toString().split(" ")[0]}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("To Date: ${widget.toDate.toString().split(" ")[0]}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              if (widget.uploadedFile != null) ...[
                const SizedBox(height: 8),
                Text("Uploaded File: ${widget.uploadedFile!.name}"),
              ],
              const SizedBox(height: 16),
              const Text("Purpose *",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _purposeController,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Purpose is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Information",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _infoController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text("SUBMIT",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
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
