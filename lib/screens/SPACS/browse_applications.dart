import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';

class BrowseApplicationsPage extends StatefulWidget {
  const BrowseApplicationsPage({super.key});

  @override
  State<BrowseApplicationsPage> createState() => _BrowseApplicationsPageState();
}

class _BrowseApplicationsPageState extends State<BrowseApplicationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _tabs = ['MCM Scholarship', 'Convocation Medals'];
  int _selectedTabIndex = 0; // 0: MCM Scholarship, 1: Convocation Medals
  PlatformFile? _selectedFile; // To store the selected file
  bool _showForm = false; // State to toggle between instructions and form
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form key for validation

  void _selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File selected: ${_selectedFile!.name}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Browse Applications',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.blue),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ],
        ),
        drawer: Sidebar(
          onItemSelected: (index) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Navigating to item $index'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
        body: Column(
          children: [
            const SizedBox(height: 16), // Margin below the app bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  return _buildTabButton(
                    index: index,
                    label: _tabs[index],
                    icon: index == 0 ? Icons.school : Icons.emoji_events,
                  );
                }),
              ),
            ),
            const SizedBox(height: 4), // Space below the tabs
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildMCMContent()
                  : _buildConvocationContent(),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildTabButton(
      {required int index, required String label, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {
          if (_selectedTabIndex != index) {
            setState(() {
              _selectedTabIndex = index;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedTabIndex == index ? Colors.blue : Colors.blue.shade50,
          foregroundColor:
              _selectedTabIndex == index ? Colors.white : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _selectedTabIndex == index ? Colors.white : Colors.blue,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: _selectedTabIndex == index ? Colors.white : Colors.blue,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMCMContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            label: 'Family ID:',
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Family ID',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'MCM ID:',
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'MCM ID',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Father\'s Occupation:',
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: const [
                DropdownMenuItem(value: 'Employed', child: Text('Employed')),
                DropdownMenuItem(
                    value: 'Self-Employed', child: Text('Self-Employed')),
                DropdownMenuItem(
                    value: 'Unemployed', child: Text('Unemployed')),
              ],
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Father\'s Income:',
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Father\'s Income',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Father\'s Occupation Description:',
            child: TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write here...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Mother\'s Occupation:',
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: const [
                DropdownMenuItem(value: 'Employed', child: Text('Employed')),
                DropdownMenuItem(
                    value: 'Self-Employed', child: Text('Self-Employed')),
                DropdownMenuItem(
                    value: 'Unemployed', child: Text('Unemployed')),
              ],
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Mother\'s Income:',
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Mother\'s Income',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Mother\'s Occupation Description:',
            child: TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write here...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Other Income:',
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Other Income',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'No. of Four Wheelers:',
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Number of Vehicles',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Four Wheeler Description:',
            child: TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write here...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'No. of Two Wheelers:',
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Number of Vehicles',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Two Wheeler Description:',
            child: TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write here...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Income Certificate:',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: _selectFile, // Call the file picker
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Text(
                              _selectedFile == null
                                  ? 'No file chosen'
                                  : _selectedFile!
                                      .name, // Display selected file name
                              style: TextStyle(
                                color: _selectedFile == null
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(7.0),
                              bottomRight: Radius.circular(7.0),
                            ),
                          ),
                          child: TextButton(
                            onPressed: _selectFile, // Call the file picker
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: Text(
                              'Browse',
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 12, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        'Accepts .pdf files only',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Attach Other Files:',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: _selectFile, // Call the file picker
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Text(
                              _selectedFile == null
                                  ? 'No file chosen'
                                  : _selectedFile!
                                      .name, // Display selected file name
                              style: TextStyle(
                                color: _selectedFile == null
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(7.0),
                              bottomRight: Radius.circular(7.0),
                            ),
                          ),
                          child: TextButton(
                            onPressed: _selectFile, // Call the file picker
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: Text(
                              'Browse',
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 12, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        'Accepts .pdf, .jpeg, .png, .jpg files only',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  if (_selectedFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please upload all required files'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form Submitted')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 15),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildConvocationContent() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0 && _showForm) {
          // Swipe right to go back to instructions
          setState(() {
            _showForm = false;
          });
        }
      },
      child:
          _showForm ? _buildConvocationForm() : _buildConvocationInstructions(),
    );
  }

  Widget _buildConvocationInstructions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please read the instructions before applying for the Convocation Medals:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5), // Light greyish-white color
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Brief description for cultural:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Write the level of participation in Cultural activities during your stay at IIITDMJ.\n'
                    '• Relevant documents are required to be uploaded.\n'
                    '• Include details such as:\n'
                    '  (a) Performance on the field - single, group (Main participant or side participant).\n'
                    '  (b) Did you win any prize/medal/award while performing the above-mentioned activity?\n'
                    '  (c) Managing cultural activity.\n'
                    '  (d) Generating funds for the conduction of activity.\n'
                    '  (e) Mention whether the activity was performed inside or outside IIITDMJ.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Please click on the PROCEED button below to fill the form.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showForm = true; // Show the form
                });
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Proceed',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConvocationForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey, // Assign the form key
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormField(
              label: 'Award:',
              child: _buildDropdown(['Select', 'Gold', 'Silver'],
                  validator: (value) {
                if (value == null || value == 'Select') {
                  return 'Please select an award';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Hall No:',
              child: _buildTextField('Hall No.', validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the hall number';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Room No:',
              child: _buildTextField('Room No.', validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the room number';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Type:',
              child: _buildDropdown(['Select', 'Type A', 'Type B'],
                  validator: (value) {
                if (value == null || value == 'Select') {
                  return 'Please select a type';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Father\'s Name:',
              child: _buildTextField('Father\'s Name', validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the father\'s name';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Mother\'s Name:',
              child: _buildTextField('Mother\'s Name', validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the mother\'s name';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Permanent Address:',
              child: _buildTextField('Write here...', maxLines: 3,
                  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the permanent address';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Correspondence Address:',
              child: _buildTextField('Write here...', maxLines: 3,
                  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the correspondence address';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Nearest Police Station:',
              child:
                  _buildTextField('Nearest Police Station', validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the nearest police station';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Nearest Railway Station:',
              child: _buildTextField('Nearest Railway Station',
                  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the nearest railway station';
                }
                return null;
              }),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form Submitted')),
                    );
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint,
      {int maxLines = 1, String? Function(String?)? validator}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown(List<String> items,
      {String? Function(String?)? validator}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {},
      validator: validator,
    );
  }
}
