import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import 'create_proposal.dart';
import 'view_proposal_tables.dart';

class FileDetailsPage extends StatefulWidget {
  final String requestId;

  const FileDetailsPage({super.key, required this.requestId});

  @override
  State<FileDetailsPage> createState() => _FileDetailsPageState();
}

class _FileDetailsPageState extends State<FileDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController remarksController = TextEditingController();

  final List<String> _designations = ['Director', 'Dean', 'Employee', 'IWD Head'];
  String? selectedDesignation;

  // Step 1: Add the success dialog function
  void _showForwardSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFD0E5F7),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_rounded, size: 40, color: Color(0xFF1E73BE)),
              ),
              const SizedBox(height: 24),
              Text("File Forwarded!",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text("The file has been successfully forwarded to $selectedDesignation.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // close dialog
                    Navigator.pop(context); // go back to previous screen
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF1E73BE),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Back to Dashboard"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Sidebar(),
      bottomNavigationBar: const BottomBar(),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) => handleGesture(details, _scaffoldKey),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "File Details #${widget.requestId}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Status
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade700),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Status", style: TextStyle(color: Colors.grey)),
                        Text("REJECTED",
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tracking History
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text("File Tracking History",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
              _buildTrackingCard(
                sentBy: "dvijay",
                sentDate: "2025-02-11T16:51:59.856861",
                receivedBy: "5424",
                remarks: "File with id:618 created by dvijay and sent to bhartenduks",
              ),
              const SizedBox(height: 12),
              _buildTrackingCard(
                sentBy: "bhartenduks",
                sentDate: "2025-02-15T09:36:43.956017",
                receivedBy: "2428",
                remarks: "-",
              ),
              const SizedBox(height: 24),

              // Proposal Buttons
              // Proposal Buttons
Row(
  children: [
    Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.description, size: 20),
        label: const Text("Proposal Form"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewProposalPage(),
            ),
          );
        },
      ),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.remove_red_eye, size: 20),
        label: const Text("View Proposals"),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue.shade800,
          side: BorderSide(color: Colors.blue.shade300),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewProposalTablesPage(),
            ),
          );
        },
      ),
    ),
  ],
),

              const SizedBox(height: 24),

              // Upload Section
              const Text("Upload File",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.shade200,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload, size: 32, color: Colors.blue.shade300),
                    const SizedBox(height: 8),
                    Text("Drag & Drop or Browse",
                        style: TextStyle(color: Colors.grey.shade600)),
                    Text("PDF, DOC, JPG (max 10MB)",
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Remarks Input
              TextField(
                controller: remarksController,
                decoration: InputDecoration(
                  labelText: "Remarks",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade800),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Designation Dropdown
              DropdownButtonFormField<String>(
                value: selectedDesignation,
                decoration: InputDecoration(
                  labelText: "Designation *",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade800),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                items: _designations
                    .map((designation) => DropdownMenuItem(
                          value: designation,
                          child: Text(designation),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDesignation = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Forward Button
              ElevatedButton.icon(
                icon: const Icon(Icons.forward, size: 20),
                label: const Text("Forward File"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if ((remarksController.text.trim().isEmpty) ||
                      (selectedDesignation == null)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter remarks and select a designation")),
                    );
                    return;
                  }

                  // Step 2: Show the success dialog
                  _showForwardSuccessDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingCard({
    required String sentBy,
    required String sentDate,
    required String receivedBy,
    required String remarks,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.person_outline, "Sent by", sentBy),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today, "Sent Date", sentDate),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.person, "Received by", receivedBy),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.comment, "Remarks", remarks),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}
