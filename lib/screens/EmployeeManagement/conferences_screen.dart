import 'package:flutter/material.dart';

class ConferencesScreen extends StatefulWidget {
  const ConferencesScreen({Key? key}) : super(key: key);

  @override
  State<ConferencesScreen> createState() => _ConferencesScreenState();
}

class _ConferencesScreenState extends State<ConferencesScreen> {
  // Form controllers for adding a conference
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _conferenceNameController =
      TextEditingController();

  @override
  void dispose() {
    _roleController.dispose();
    _venueController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _conferenceNameController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conferences'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add a Conference/Symposium',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(label: 'Role*', controller: _roleController),
            _buildTextField(label: 'Venue*', controller: _venueController),
            _buildTextField(
                label: 'Start Date*', controller: _startDateController),
            _buildTextField(label: 'End Date*', controller: _endDateController),
            _buildTextField(
                label: 'Conference Name*',
                controller: _conferenceNameController),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save conference details
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Projects Report',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'No Conferences Found',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
