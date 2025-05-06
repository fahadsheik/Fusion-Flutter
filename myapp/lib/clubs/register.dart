import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Registration'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.blue, width: 10))),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              const Text(
                'The Programming Club',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFormField('Name'),
              _buildFormField('Roll no.'),
              _buildFormField('Year'),
              _buildFormField('Department'),
              _buildFormField('Email'),
              _buildFormField('Phone'),
              _buildFormField('Date: Any previous experience in the domain'),
              _buildFormField('Base: Any achievements'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration submitted successfully!')),
    );
    Navigator.pop(context);
  }
}