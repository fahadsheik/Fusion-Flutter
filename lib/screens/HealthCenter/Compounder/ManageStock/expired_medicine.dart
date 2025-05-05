import 'package:flutter/material.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../../utils/gesture_sidebar.dart';
import '../../../../utils/sidebar.dart';

class ExpiredMedicine extends StatefulWidget {
  const ExpiredMedicine({super.key});

  @override
  State<ExpiredMedicine> createState() => _ExpiredMedicineState();
}

class _ExpiredMedicineState extends State<ExpiredMedicine> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  // Dummy data for expired medicines
  // Replace the existing _medicineData list with:

final List<Map<String, dynamic>> _medicineData = [
  {
    'medicine': 'Dolo 650',
    'supplier': 'Medplus',
    'expiryDate': '12/05/2024',
    'quantity': '20',
  },
  {
    'medicine': 'Crocin Advance',
    'supplier': 'CarePlus',
    'expiryDate': '15/05/2024',
    'quantity': '30',
  },
  {
    'medicine': 'Azithromycin 500',
    'supplier': 'Apollo Pharmacy',
    'expiryDate': '20/05/2024',
    'quantity': '15',
  },
  {
    'medicine': 'Amoxicillin 250',
    'supplier': 'Medplus',
    'expiryDate': '25/05/2024',
    'quantity': '25',
  },
  {
    'medicine': 'Cetrizine',
    'supplier': 'MedCart',
    'expiryDate': '01/06/2024',
    'quantity': '40',
  },
  {
    'medicine': 'Omeprazole',
    'supplier': 'CarePlus',
    'expiryDate': '05/06/2024',
    'quantity': '35',
  },
  {
    'medicine': 'Pantoprazole',
    'supplier': 'Apollo Pharmacy',
    'expiryDate': '10/06/2024',
    'quantity': '28',
  },
  {
    'medicine': 'Metformin 500',
    'supplier': 'Medplus',
    'expiryDate': '15/06/2024',
    'quantity': '45',
  },
  {
    'medicine': 'Aspirin 150',
    'supplier': 'MedCart',
    'expiryDate': '20/06/2024',
    'quantity': '50',
  },
  {
    'medicine': 'Montair LC',
    'supplier': 'CarePlus',
    'expiryDate': '25/06/2024',
    'quantity': '22',
  },
];

  List<Map<String, dynamic>> get filteredData {
    if (_searchController.text.isEmpty) return _medicineData;
    return _medicineData.where((medicine) => 
      medicine['medicine'].toString().toLowerCase().contains(_searchController.text.toLowerCase()) ||
      medicine['supplier'].toString().toLowerCase().contains(_searchController.text.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Expired Medicine',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue.shade700,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Sidebar(onItemSelected: (index) {}),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Medicine',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Supplier',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Expiry Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Quantity',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            final data = filteredData[index];
                            final isSelected = index % 2 == 1;
                            return Container(
                              padding: const EdgeInsets.all(16),
                              color: isSelected ? Color(0xFFE0F2F1) : null,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(data['medicine']),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(data['supplier']),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(data['expiryDate']),
                                  ),
                                  Expanded(
                                    child: Text(data['quantity']),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle download functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}