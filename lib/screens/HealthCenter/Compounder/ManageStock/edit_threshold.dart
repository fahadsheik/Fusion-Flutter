import 'package:flutter/material.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../../utils/gesture_sidebar.dart';
import '../../../../utils/sidebar.dart';
import '../health_dashboard.dart';

class EditThreshold extends StatefulWidget {
  const EditThreshold({super.key});

  @override
  State<EditThreshold> createState() => _EditThresholdState();
}

class _EditThresholdState extends State<EditThreshold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Form Controllers
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _thresholdController = TextEditingController();
  final TextEditingController _manufacturerNameController = TextEditingController();
  final TextEditingController _packSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Edit Threshold',
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
                  'Brand Name',
                  TextFormField(
                    controller: _brandNameController,
                    decoration: _getInputDecoration('Enter Brand Name'),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
                _buildFormField(
                  'Threshold',
                  TextFormField(
                    controller: _thresholdController,
                    decoration: _getInputDecoration('Enter Threshold'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
                _buildFormField(
                  'Manufacturer Name',
                  TextFormField(
                    controller: _manufacturerNameController,
                    decoration: _getInputDecoration('Enter Manufacturer Name'),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
                _buildFormField(
                  'Pack Size Label',
                  TextFormField(
                    controller: _packSizeController,
                    decoration: _getInputDecoration('Enter Pack Size'),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
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
        content: const Text('Threshold updated successfully'),
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
    _brandNameController.dispose();
    _thresholdController.dispose();
    _manufacturerNameController.dispose();
    _packSizeController.dispose();
    super.dispose();
  }
}