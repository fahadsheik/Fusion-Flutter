import 'package:flutter/material.dart';
import 'visitor_details_page.dart';
import 'menu.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  String? selectedRooms;
  String? selectedPeople;
  String? selectedCategory;
  String? selectedPurpose;
  DateTime? startDate;
  DateTime? endDate;
  bool isBillsChecked = false;

  final TextEditingController _intenderController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime initialDate =
        isStart ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_intenderController.text.isEmpty ||
        startDate == null ||
        endDate == null ||
        selectedRooms == null ||
        selectedPeople == null ||
        selectedCategory == null ||
        selectedPurpose == null ||
        _remarksController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all details."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  VisitorDetailsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/sindu_vakkurthy.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Sindhu Vukkurthy",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SidebarMenu()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("MENU"),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Visitor’s Hostel",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("Manage Bookings"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Booking Form",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Booking Request Form",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildTextField("Intender Id", _intenderController),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildDateField("Start", startDate, () => _selectDate(context, true)),
                  const SizedBox(width: 20),
                  _buildDateField("End", endDate, () => _selectDate(context, false)),
                ],
              ),
              const SizedBox(height: 20),
              _buildDropdown("Number of rooms", ["1", "2", "3", "4+"], selectedRooms,
                  (val) => setState(() => selectedRooms = val)),
              _buildDropdown("Number of people", ["1", "2", "3", "4+"], selectedPeople,
                  (val) => setState(() => selectedPeople = val)),
              _buildDropdown("Category", ["A", "B", "C"], selectedCategory,
                  (val) => setState(() => selectedCategory = val)),
              _buildDropdown(
                  "Purpose of visit", ["Official", "Personal", "Other"], selectedPurpose,
                  (val) => setState(() => selectedPurpose = val)),
              const SizedBox(height: 10),
              _buildRemarksField(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: isBillsChecked,
                    onChanged: (value) {
                      setState(() {
                        isBillsChecked = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text("Bills to pay",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Submit Request",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String? selected,
      ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField<String>(
        value: selected,
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.calendar_today, color: Colors.black),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(date != null
                  ? "${date.year}-${date.month}-${date.day}"
                  : "Select date"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemarksField() {
    return TextField(
      controller: _remarksController,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Remarks",
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: BookingForm(),
    debugShowCheckedModeBanner: false,
  ));
}
