import 'package:flutter/material.dart';
import '../../utils/bottom_bar.dart';
import 'inventory_department_screen.dart';

class InventoryDepartmentDetailScreen extends StatefulWidget {
  final String department;
  
  const InventoryDepartmentDetailScreen({
    super.key,
    required this.department,
  });

  @override
  State<InventoryDepartmentDetailScreen> createState() => _InventoryDepartmentDetailScreenState();
}

class _InventoryDepartmentDetailScreenState extends State<InventoryDepartmentDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  
  // Sample data for the department inventory with only "Consumable" and "Non-Consumable" types
  final List<Map<String, dynamic>> _inventoryData = [
    {
      'product': 'Laptops',
      'productId': 'LP001',
      'type': 'Non-Consumable',
      'quantity': 32,
      'location': 'Lab 101',
      'transferCount': 5,
      'transferStatus': 'Not Transferred',
    },
    {
      'product': 'Monitors',
      'productId': 'MN002',
      'type': 'Non-Consumable',
      'quantity': 40,
      'location': 'Lab 102',
      'transferCount': 12,
      'transferStatus': 'Transferred',
    },
    {
      'product': 'Paper Reams',
      'productId': 'PR003',
      'type': 'Consumable',
      'quantity': 150,
      'location': 'Store Room',
      'transferCount': 45,
      'transferStatus': 'Not Transferred',
    },
    {
      'product': 'Projectors',
      'productId': 'PJ004',
      'type': 'Non-Consumable',
      'quantity': 10,
      'location': 'Classrooms',
      'transferCount': 8,
      'transferStatus': 'Transferred',
    },
    {
      'product': 'Whiteboard Markers',
      'productId': 'WM005',
      'type': 'Consumable',
      'quantity': 200,
      'location': 'Store Room',
      'transferCount': 85,
      'transferStatus': 'Not Transferred',
    },
  ];
  
  List<Map<String, dynamic>> _filteredData = [];
  
  @override
  void initState() {
    super.initState();
    _filteredData = List.from(_inventoryData);
  }
  
  void _filterData() {
    setState(() {
      if (_selectedFilter == 'All') {
        _filteredData = _inventoryData
            .where((item) => item['product']
                .toString()
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      } else {
        _filteredData = _inventoryData
            .where((item) => 
                item['type'] == _selectedFilter &&
                item['product']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  void _showTypeFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Filter by Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('All'),
              const SizedBox(height: 8),
              _buildFilterOption('Consumable'),
              const SizedBox(height: 8),
              _buildFilterOption('Non-Consumable'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption(String type) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = type;
          _filterData();
          Navigator.pop(context);
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedFilter == type ? Colors.blue : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
          color: _selectedFilter == type ? Colors.blue.shade50 : Colors.white,
        ),
        child: Text(
          type,
          style: TextStyle(
            fontWeight: _selectedFilter == type ? FontWeight.bold : FontWeight.normal,
            color: _selectedFilter == type ? Colors.blue.shade700 : Colors.black,
          ),
        ),
      ),
    );
  }

  void _showAddProductForm() {
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController productIdController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController transferCountController = TextEditingController();
    
    String selectedType = 'Non-Consumable';
    String selectedTransferStatus = 'Not Transferred';
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Add New Product',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    const Text('Product Name', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: productNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Enter product name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Product ID
                    const Text('Product ID', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: productIdController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Enter product ID',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Quantity
                    const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Enter quantity',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Type
                    const Text('Type', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<String>(
                        value: selectedType,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 'Consumable',
                            child: Text('Consumable'),
                          ),
                          DropdownMenuItem(
                            value: 'Non-Consumable',
                            child: Text('Non-Consumable'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Location
                    const Text('Location', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Enter location',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Transfer Count
                    const Text('Transfer Count', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: transferCountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Enter transfer count',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Transfer Status
                    const Text('Transfer Status', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<String>(
                        value: selectedTransferStatus,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 'Transferred',
                            child: Text('Transferred'),
                          ),
                          DropdownMenuItem(
                            value: 'Not Transferred',
                            child: Text('Not Transferred'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedTransferStatus = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add product to the list (mock implementation)
                    if (productNameController.text.isNotEmpty && 
                        productIdController.text.isNotEmpty &&
                        quantityController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product added successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all required fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add Product'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showTransferProductForm() {
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController productIdController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    
    String selectedDepartment = 'CSE DEPARTMENT';
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Transfer Product',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    const Text('Product Name', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: productNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Enter product name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Product ID
                    const Text('Product ID', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: productIdController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Enter product ID',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Quantity
                    const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Enter quantity to transfer',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // To Department
                    const Text('To Department', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<String>(
                        value: selectedDepartment,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 'CSE DEPARTMENT',
                            child: Text('CSE DEPARTMENT'),
                          ),
                          DropdownMenuItem(
                            value: 'ECE DEPARTMENT',
                            child: Text('ECE DEPARTMENT'),
                          ),
                          DropdownMenuItem(
                            value: 'ME DEPARTMENT',
                            child: Text('ME DEPARTMENT'),
                          ),
                          DropdownMenuItem(
                            value: 'SM DEPARTMENT',
                            child: Text('SM DEPARTMENT'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedDepartment = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Date
                    const Text('Date', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        hintText: 'Select date',
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          dateController.text = '${date.day}-${date.month}-${date.year}';
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Transfer product logic (mock implementation)
                    if (productNameController.text.isNotEmpty && 
                        productIdController.text.isNotEmpty &&
                        quantityController.text.isNotEmpty &&
                        dateController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product transferred successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all required fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Transfer'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.department,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('assets/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'pg_admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          
          // Action buttons row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildActionButton('Filter', Icons.filter_list, onTap: _showTypeFilterDialog),
                const SizedBox(width: 8),
                _buildActionButton('Add Product', Icons.add, onTap: _showAddProductForm),
                const SizedBox(width: 8),
                _buildActionButton('Transfer Product', Icons.swap_horiz, onTap: _showTransferProductForm),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Department heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.department,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Product',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 10),
                      ),
                      onChanged: (value) {
                        _filterData();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: _filterData,
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Filter indicator if active
          if (_selectedFilter != 'All')
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_list, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      'Filtered by: $_selectedFilter',
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedFilter = 'All';
                          _filterData();
                        });
                      },
                      child: const Icon(Icons.close, size: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          
          const SizedBox(height: 16),
          
          // Table
          Expanded(
            child: _filteredData.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No items found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            // Table header
                            Container(
                              color: Colors.grey.shade100,
                              child: Row(
                                children: [
                                  _buildTableHeaderCell('Product', 100),
                                  _buildTableHeaderCell('Type', 120),
                                  _buildTableHeaderCell('Quantity', 80),
                                  _buildTableHeaderCell('Location', 100),
                                  _buildTableHeaderCell('Transfer Count', 120),
                                  _buildTableHeaderCell('Transfer Status', 130),
                                ],
                              ),
                            ),
                            
                            // Table rows
                            ...List.generate(
                              _filteredData.length,
                              (index) {
                                final item = _filteredData[index];
                                
                                return Container(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.teal.shade50,
                                  child: Row(
                                    children: [
                                      _buildTableCell(item['product'].toString(), 100),
                                      _buildTableCell(item['type'].toString(), 120),
                                      _buildTableCell(item['quantity'].toString(), 80),
                                      _buildTableCell(item['location'].toString(), 100),
                                      _buildTableCell(item['transferCount'].toString(), 120),
                                      _buildTableCell(item['transferStatus'].toString(), 130),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 0),
    );
  }

  Widget _buildActionButton(String label, IconData icon, {required VoidCallback onTap}) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeaderCell(String title, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}