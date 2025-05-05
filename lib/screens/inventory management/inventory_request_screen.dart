import 'package:flutter/material.dart';
import '../../utils/bottom_bar.dart';
import 'inventory_dashboard.dart';

class InventoryRequestScreen extends StatefulWidget {
  const InventoryRequestScreen({super.key});

  @override
  State<InventoryRequestScreen> createState() => _InventoryRequestScreenState();
}

class _InventoryRequestScreenState extends State<InventoryRequestScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All Requests';
  
  final List<Map<String, dynamic>> _requestData = [
    {
      'product': 'Monitors',
      'date': '12-10-2024',
      'quantity': 53,
      'department': 'CSE',
      'status': 'Approved',
    },
    {
      'product': 'Speakers',
      'date': '15-08-2024',
      'quantity': 40,
      'department': 'ECE',
      'status': 'Pending',
    },
    {
      'product': 'Study Tables',
      'date': '4-02-2024',
      'quantity': 20,
      'department': 'Mgt Sciences',
      'status': 'Cancelled',
    },
    {
      'product': 'Chairs',
      'date': '18-03-2024',
      'quantity': 35,
      'department': 'Law',
      'status': 'Approved',
    },
    {
      'product': 'Whiteboards',
      'date': '22-04-2025',
      'quantity': 15,
      'department': 'Engineering',
      'status': 'Pending',
    },
  ];

  List<Map<String, dynamic>> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filteredData = List.from(_requestData);
  }

  void _filterData() {
    setState(() {
      if (_selectedFilter == 'All Requests') {
        _filteredData = _requestData
            .where((item) => item['product']
                .toString()
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      } else if (_selectedFilter == 'Approved') {
        _filteredData = _requestData
            .where((item) =>
                item['status'] == 'Approved' &&
                item['product']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      } else if (_selectedFilter == 'Cancelled') {
        _filteredData = _requestData
            .where((item) =>
                item['status'] == 'Cancelled' &&
                item['product']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      } else if (_selectedFilter == 'Pending') {
        _filteredData = _requestData
            .where((item) =>
                item['status'] == 'Pending' &&
                item['product']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Requests',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const InventoryDashboard(),
              ),
            );
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
                    borderRadius: BorderRadius.circular(8),
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
          // Filter tabs
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip('All Requests'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Approved'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Cancelled'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Pending'),
                ],
              ),
            ),
          ),

          // Requests title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Requests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),

          // Search box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    height: 40,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Enter Product',
                        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      onChanged: (value) {
                        _filterData();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 40,
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

          const SizedBox(height: 16),

          // Table
          Expanded(
            child: _filteredData.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No requests found',
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Table header
                            Container(
                              color: Colors.grey.shade100,
                              child: Row(
                                children: [
                                  _buildTableHeaderCell('Product', 150),
                                  _buildTableHeaderCell('Date', 100),
                                  _buildTableHeaderCell('Quantity', 100),
                                  _buildTableHeaderCell('Department', 150),
                                  _buildTableHeaderCell('Status', 100),
                                ],
                              ),
                            ),
                            // Table data
                            ...List.generate(
                              _filteredData.length,
                              (index) {
                                final item = _filteredData[index];
                                return Container(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.grey.shade50,
                                  child: Row(
                                    children: [
                                      _buildTableCell(item['product'].toString(), 150),
                                      _buildTableCell(item['date'].toString(), 100),
                                      _buildTableCell(item['quantity'].toString(), 100),
                                      _buildTableCell(item['department'].toString(), 150),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Container(
                                          width: 76,
                                          height: 28,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(item['status'].toString()),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            item['status'].toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
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

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
          _filterData();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blue,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}