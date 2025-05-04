import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion/screens/Mess%20Management/mess_dashboard.dart';
import 'package:path/path.dart' as path;
import '../../utils/bottom_bar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/sidebar.dart';
import '../Examination/examination_dashboard.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    TextEditingController _transactionNumberController =
        TextEditingController();
    TextEditingController _amountController = TextEditingController();
    TextEditingController _paymentDateController = TextEditingController();
    TextEditingController _startDateController = TextEditingController();
    bool _isFileSelected = false;
    final TextEditingController _fileTextController = TextEditingController();
    PlatformFile? _selectedFile;
    bool _isLoading = false;

    void _showSnackBar(String message, {bool isError = false}) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    Future<void> _selectFile() async {
      try {
        setState(() {
          _isLoading = true;
        });

        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['png', 'jpeg', 'jpg'],
          allowMultiple: false,
        );

        setState(() {
          _isLoading = false;
        });

        if (result != null) {
          setState(() {
            _selectedFile = result.files.first;
            _isFileSelected = true;
            _fileTextController.text = _selectedFile!.name;
            print('File path of image: ${_fileTextController.text}');
          });

          _showSnackBar('Image selected: ${_selectedFile!.name}');
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        _showSnackBar('Error picking image: $e', isError: true);
      }
    }

    String _getScreenName(int index) {
      switch (index) {
        case 0:
          return 'Dashboard';
        case 1:
          return 'Orders';
        case 2:
          return 'Announcement';
        case 3:
          return 'Submit Grades';
        case 4:
          return 'Verify Grades';
        case 5:
          return 'Generate Transcript';
        case 6:
          return 'Profile';
        case 7:
          return 'Settings';
        case 8:
          return 'Help';
        case 9:
          return 'Log out';
        default:
          return 'Unknown';
      }
    }

    Widget _buildDatePickerFormField({
      required String label,
      required TextEditingController controller,
    }) {
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
          TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'YY/MM/DD',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixIcon: const Icon(
                Icons.calendar_today,
                size: 16,
              ),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                controller.text =
                    "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
              }
            },
          ),
        ],
      );
    }

    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Registration Form',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessDashboard(),
                ),
              );
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
            if (index == 57) {
              // Already on Verify Grades screen
            } else if (index == 0) {
              Navigator.pop(context);
            } else {
              _showSnackBar('Navigating to ${_getScreenName(index)}');
            }
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextFormField(
                        label: 'Transaction Number *',
                        hintText: 'Enter transaction number',
                        controller: _transactionNumberController),
                    const SizedBox(height: 16),
                    _buildTextFormField(
                        label: 'Amount *',
                        hintText: 'Enter amount',
                        controller: _amountController),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Image *',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: _selectFile,
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
                                      _fileTextController.text.isEmpty
                                          ? 'No file chosen'
                                          : _selectedFile!.name,
                                      style: TextStyle(
                                        color: _fileTextController.text.isEmpty
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
                                    onPressed: _selectFile,
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                    ),
                                    child: Text(
                                      'Browse',
                                      style: TextStyle(
                                          color: Colors.blue.shade700),
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
                                'Accepts images only',
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
                    if (_isFileSelected && _selectedFile != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              // Icon(
                              //   _getFileIcon(_selectedFile!.name),
                              //   color: _selectedFile!.name.endsWith('.csv')
                              //       ? Colors.blue
                              //       : Colors.green,
                              // ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedFile!.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      _formatFileSize(_selectedFile!.size),
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.close,
                                    color: Colors.red, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _isFileSelected = false;
                                    _fileTextController.text = '';
                                    _selectedFile = null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    _buildDatePickerFormField(
                        label: 'Payment Date *',
                        controller: _paymentDateController),
                    const SizedBox(height: 16),
                    _buildDatePickerFormField(
                        label: 'Start Date *',
                        controller: _startDateController),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      double kb = bytes / 1024;
      return '${kb.toStringAsFixed(1)} KB';
    } else {
      double mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(1)} MB';
    }
  }

  Widget _buildTextFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
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
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
