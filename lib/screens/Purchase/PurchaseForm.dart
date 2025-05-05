import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PurchaseForm(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class PurchaseForm extends StatelessWidget {
  const PurchaseForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoCard(),
            SizedBox(height: 16),
            CustomTextField(label: "Name of the Indenter*"),
            CustomTextField(label: "Designation*"),
            CustomTextField(label: "Item name*"),
            CustomTextField(label: "Present stock*"),
            CustomTextField(label: "Purchase & Justification"),
            CustomTextField(label: "Item type*"),
            RadioGroup(title: "Nature of Item*", options: ["Consumable", "Non Consumable"]),
            RadioGroup(title: "Replacement*", options: ["Yes", "No"]),
            CustomTextField(label: "If Replace (give details)"),
            CustomTextField(label: "Budgetary Head"),
            CustomTextField(label: "Expected Delivery*"),
            CustomTextField(label: "Source of Supply*"),
            CustomTextField(label: "Attach file"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Center(
                child: Text("Add item", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            SizedBox(height: 10),
            CustomTextField(label: "Forward To:*"),
            CustomTextField(label: "Receiver Designation*"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Center(
                child: Text("Delete", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Info Card
class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF4FCFA),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoText(label: "File Id", value: "10"),
            InfoText(label: "Indent Item", value: "Projector"),
            InfoText(label: "Date", value: "15-02-2025"),
          ],
        ),
      ),
    );
  }
}

// Custom Label-Value Text
class InfoText extends StatelessWidget {
  final String label, value;
  const InfoText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(
              text: "$label : ",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          TextSpan(text: value, style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}

// Custom Input Field
class CustomTextField extends StatelessWidget {
  final String label;
  const CustomTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

// Radio Group for Single Selection
class RadioGroup extends StatefulWidget {
  final String title;
  final List<String> options;

  const RadioGroup({super.key, required this.title, required this.options});

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ...widget.options.map((option) => RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          )),
        ],
      ),
    );
  }
}
