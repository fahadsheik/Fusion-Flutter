import 'package:flutter/material.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';
import 'view_proposal_tables.dart';
import 'create_proposal.dart';

const Color kPrimaryBlue = Color(0xFF1E73BE);

class FileDetailsApproveReject extends StatefulWidget {
  final String requestId;
  final String requestName;

  const FileDetailsApproveReject({
    super.key,
    required this.requestId,
    required this.requestName,
  });

  @override
  State<FileDetailsApproveReject> createState() =>
      _FileDetailsApproveRejectState();
}

class _FileDetailsApproveRejectState extends State<FileDetailsApproveReject> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedDesignation = 'Director';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) => handleGesture(details, scaffoldKey),
      child: Scaffold(
        key: scaffoldKey,
        drawer: const Sidebar(),
        bottomNavigationBar: const BottomBar(),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: kPrimaryBlue),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "File Review #${widget.requestId}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSectionHeader("Request Information"),
              _buildDetailRow('Created By:', 'dvijay'),
              const Divider(height: 40),

              _buildSectionHeader("File Tracking Information"),
              _buildTrackingDetail('Sent by:', 'dvijay'),
              _buildTrackingDetail(
                  'Sent Date & Time:', '2025-02-18T23:55:28 72/4/5'),
              _buildTrackingDetail('Received by:', '5424'),
              _buildTrackingDetail('Remarks:',
                  'File with id 627 created by dvijay and sent to bharlendulss'),
              const Divider(height: 40),

              _buildSectionHeader("Proposal Form"),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.description, size: 18),
                      label: const Text("View Proposals"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kPrimaryBlue,
                        side: const BorderSide(color: kPrimaryBlue),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ViewProposalTablesPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.list_alt, size: 18),
                      label: const Text("Proposal Form"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kPrimaryBlue,
                        side: const BorderSide(color: kPrimaryBlue),
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
                ],
              ),
              const SizedBox(height: 24),

              _buildSectionHeader("Upload your file"),
              _buildFileUploadSection(),
              const SizedBox(height: 24),

              _buildSectionHeader("Remarks"),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your remarks...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionHeader("Designation"),
              DropdownButtonFormField<String>(
                value: selectedDesignation,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Director', child: Text('Director')),
                  DropdownMenuItem(value: 'Dean', child: Text('Dean')),
                  DropdownMenuItem(value: 'IWD Head', child: Text('IWD Head')),
                  DropdownMenuItem(value: 'Employee', child: Text('Employee')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedDesignation = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle, size: 20),
                      label: const Text("Approve File"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _showApprovalDialog(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.cancel, size: 20),
                      label: const Text("Reject File"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _showRejectionDialog(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kPrimaryBlue,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(
              text: label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            TextSpan(
              text: ' $value',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadSection() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryBlue.withOpacity(0.3), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload,
              size: 32, color: kPrimaryBlue.withOpacity(0.5)),
          const SizedBox(height: 8),
          const Text("Drag & Drop or Browse",
              style: TextStyle(color: Colors.grey)),
          const Text("PDF, DOC, JPG (max 10MB)",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  void _showApprovalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.green.shade100, shape: BoxShape.circle),
                child: const Icon(Icons.check_circle,
                    size: 40, color: Colors.green),
              ),
              const SizedBox(height: 24),
              const Text("File Approved!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text("The file has been successfully approved.",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Back to List"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRejectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.red.shade100, shape: BoxShape.circle),
                child: const Icon(Icons.error_outline,
                    size: 40, color: Colors.red),
              ),
              const SizedBox(height: 24),
              const Text("File Rejected!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text("The file has been successfully rejected.",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Back to List"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
