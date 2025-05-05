import 'package:flutter/material.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../../utils/gesture_sidebar.dart';
import '../../../../utils/sidebar.dart';
import '../health_dashboard.dart';

class UpdatePatientLog extends StatefulWidget {
  const UpdatePatientLog({super.key});

  @override
  State<UpdatePatientLog> createState() => _UpdatePatientLogState();
}

class _UpdatePatientLogState extends State<UpdatePatientLog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Form Controllers
  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _diseaseDetailsController = TextEditingController();
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _timesPerDayController = TextEditingController();
  final TextEditingController _textSuggestedController = TextEditingController();
  final TextEditingController _fileTextController = TextEditingController();

  String? _selectedDoctor;
  List<String> doctors = ['Dr. Smith', 'Dr. Johnson', 'Dr. Williams'];

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Update Patient Log',
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFormField(
                  'Patient ID*',
                  TextFormField(
                    controller: _patientIdController,
                    decoration: _getInputDecoration('Enter Patient ID'),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
                _buildFormField(
                  'Doctor*',
                  DropdownButtonFormField<String>(
                    value: _selectedDoctor,
                    decoration: _getInputDecoration('Select Doctor'),
                    items: doctors.map((String doctor) {
                      return DropdownMenuItem(value: doctor, child: Text(doctor));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() => _selectedDoctor = newValue);
                    },
                    validator: (value) => value == null ? 'Required' : null,
                  ),
                ),
                _buildFormField(
                  'Details of Disease*',
                  TextFormField(
                    controller: _diseaseDetailsController,
                    maxLines: 3,
                    decoration: _getInputDecoration('Enter disease details'),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
                _buildMedicineSection(),
                _buildFormField(
                  'Text Suggested',
                  TextFormField(
                    controller: _textSuggestedController,
                    maxLines: 3,
                    decoration: _getInputDecoration('Enter suggestions'),
                  ),
                ),
                _buildFormField(
                  'Report',
                  TextField(
                    controller: _fileTextController,
                    readOnly: true,
                    decoration: _getInputDecoration('Choose file').copyWith(
                      suffixIcon: TextButton(
                        onPressed: () {
                          // TODO: Implement file picking
                        },
                        child: Text(
                          'Browse',
                          style: TextStyle(color: Colors.blue.shade700),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Submit',
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
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildMedicineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Medicine Details*',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _medicineController,
                decoration: _getInputDecoration('Select Medicine'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _quantityController,
                decoration: _getInputDecoration('Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _daysController,
                decoration: _getInputDecoration('No. of days'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _timesPerDayController,
                decoration: _getInputDecoration('Times per day'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormField(String label, Widget field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          field,
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintText: hint,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        _showSuccessDialog();
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Patient log updated successfully'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HealthDashboard(),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _patientIdController.dispose();
    _diseaseDetailsController.dispose();
    _medicineController.dispose();
    _quantityController.dispose();
    _daysController.dispose();
    _timesPerDayController.dispose();
    _textSuggestedController.dispose();
    _fileTextController.dispose();
    super.dispose();
  }
}