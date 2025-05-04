import 'package:flutter/material.dart';
import 'package:fusion/screens/iwd/request_status.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';

class NewProposalPage extends StatefulWidget {
  const NewProposalPage({Key? key}) : super(key: key);

  @override
  State<NewProposalPage> createState() => _NewProposalPageState();
}

class _NewProposalPageState extends State<NewProposalPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _idController = TextEditingController();

  List<Item> items = [];
  double totalPrice = 0.0;

  final List<String> _designations = ['Director', 'Dean', 'Employee', 'IWD Head'];
  String _selectedDesignation = 'Director';

  @override
  void initState() {
    super.initState();
    addNewItem();
  }

  @override
  void dispose() {
    _idController.dispose();
    for (var item in items) {
      item.dispose();
    }
    super.dispose();
  }

  void updateTotalPrice() {
    double total = 0.0;
    for (var item in items) {
      final quantity = int.tryParse(item.quantityController.text) ?? 0;
      final price = double.tryParse(item.priceController.text) ?? 0.0;
      total += quantity * price;
    }
    setState(() {
      totalPrice = total;
    });
  }

  void addNewItem() {
    final newItem = Item();
    newItem.quantityController.addListener(updateTotalPrice);
    newItem.priceController.addListener(updateTotalPrice);

    setState(() {
      items.add(newItem);
      updateTotalPrice();
    });
  }

  void removeItem(int index) {
    items[index].dispose();
    setState(() {
      items.removeAt(index);
      updateTotalPrice();
    });
  }

  Widget _buildInputField(
    String label, {
    TextEditingController? controller,
    String? hintText,
    int maxLines = 1,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: required ? "$label *" : label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDashedUploadBox(String label) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload, size: 32, color: Colors.grey.shade600),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
          ),
          SizedBox(height: 4),
          Text(
            "PDF, DOC, JPG (max 10MB)",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Item item, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Item ${index + 1}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                Spacer(),
                if (items.length > 1)
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
                    onPressed: () => removeItem(index),
                  ),
              ],
            ),
            SizedBox(height: 12),
            _buildInputField("Name", controller: item.nameController, required: true, hintText: "Enter item name"),
            _buildInputField("Description", controller: item.descController, required: true, hintText: "Item description", maxLines: 2),
            Row(
              children: [
                Expanded(
                  child: _buildInputField("Unit", controller: item.unitController, required: true, hintText: "pcs, kg"),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildInputField("Quantity", controller: item.quantityController, required: true, hintText: "0", keyboardType: TextInputType.number),
                ),
              ],
            ),
            _buildInputField("Price Per Unit", controller: item.priceController, required: true, hintText: "0.00", keyboardType: TextInputType.number),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Item Document (Optional)", style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            ),
            SizedBox(height: 8),
            _buildDashedUploadBox("Choose a file"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) => handleGesture(details, _scaffoldKey),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Sidebar(),
        bottomNavigationBar: BottomBar(),
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
               Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_new),
      ),
      const Text(
        'Create Proposal',
        style: TextStyle(
          color: kPrimaryBlue,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      GestureDetector(
        onTap: () => _scaffoldKey.currentState?.openDrawer(),
        child: const Icon(Icons.menu),
      ),
    ],
  ),
),

                SizedBox(height: 24),

                _buildInputField("Proposal ID", controller: _idController, required: true, hintText: "e.g. PRO-2025-001"),

                ...items.asMap().entries.map((entry) => _buildItemCard(entry.value, entry.key)),

                Center(
                  child: OutlinedButton.icon(
                    onPressed: addNewItem,
                    icon: Icon(Icons.add, size: 20),
                    label: Text("Add Another Item"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: BorderSide(color: Colors.blue),
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calculate, color: Colors.blue.shade800),
                      SizedBox(width: 12),
                      Text("Total Price: ", style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                      Text("₹ ${totalPrice.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade800)),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                Text("Supporting Documents (Optional)", style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                SizedBox(height: 8),
                _buildDashedUploadBox("Choose a file"),
                SizedBox(height: 24),

                // Dropdown for Designation
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Designation *",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDesignation,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDesignation = newValue!;
                          });
                        },
                        items: _designations.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.check, size: 20),
                        label: Text("Submit"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey.shade700,
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Cancel"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void dispose() {
    nameController.dispose();
    descController.dispose();
    unitController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }
}
