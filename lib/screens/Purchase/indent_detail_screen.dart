import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'note_sheet_screen.dart'; // Import NoteSheetScreen

class IndentDetailScreen extends StatefulWidget {
  const IndentDetailScreen({super.key});

  @override
  State<IndentDetailScreen> createState() => _IndentDetailScreenState();
}

class _IndentDetailScreenState extends State<IndentDetailScreen> {
  final List<UploadFile> _selectedFiles = [];
  final TextEditingController _remarksController = TextEditingController();
  String? _forwardTo;
  String? _receiverDesignation;

  Future<void> _pickMultipleFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          for (PlatformFile platformFile in result.files) {
            final uploadFile = UploadFile(
              file: File(platformFile.path!),
              name: platformFile.name,
              type: _getFileType(platformFile),
            );
            _selectedFiles.add(uploadFile);
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${result.files.length} file(s) selected'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking files: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getFileType(PlatformFile file) {
    final extension = file.extension?.toLowerCase() ?? '';
    if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)) {
      return 'image';
    }
    return 'document';
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.description, size: 24),
            const SizedBox(width: 8),
            const Text("Indent #10-Projector"),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Approval Section
            Row(
              children: [
                Column(
                  children: [
                    _buildApprovalCircle(true),
                    Container(
                      width: 2,
                      height: 40,
                      color: Colors.blue,
                    ),
                    _buildApprovalCircle(true),
                    Container(
                      width: 2,
                      height: 40,
                      color: Colors.grey.shade300,
                    ),
                    _buildApprovalCircle(false),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader("Head Approval"),
                      _buildSectionContent("Department head approval status"),
                      const SizedBox(height: 32),
                      _buildSectionHeader("Director Approval"),
                      _buildSectionContent("Director approval status"),
                      const SizedBox(height: 32),
                      _buildSectionHeader("Bill Approval"),
                      _buildSectionContent("Financial clearance status"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description Section
            _buildSectionHeader("Description"),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade100,
              child: const Text(
                "Computer",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Note Sheets and Attachments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to NoteSheetScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NoteSheetScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.description_outlined, size: 20),
                      const SizedBox(width: 8),
                      _buildSectionHeader("Note Sheets"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.attach_file, size: 20),
                    const SizedBox(width: 8),
                    _buildSectionHeader("Attachments"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Created By Section
            _buildCreatedBySection(),
            const SizedBox(height: 16),

            // Indent Details
            _buildIndentDetailsTable(),
            const SizedBox(height: 24),

            // Forward Indent Section
            _buildForwardIndentSection(),
            const SizedBox(height: 24),

            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalCircle(bool isApproved) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: isApproved ? Colors.blue : Colors.grey.shade300,
      child: isApproved
          ? const Icon(Icons.check, color: Colors.white, size: 16)
          : const SizedBox(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildCreatedBySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Created by: -atul-professor"),
            const SizedBox(height: 4),
            Text(
              "FILE ID: CSE-2024-02-#741",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIndentDetailsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Colors.blue.shade50,
          child: const Text(
            "INDENT DETAILS",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 2,
              child: Text("Computer"),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "QTY1",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Expanded(
              child: Text(
                "₹4,525",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Stock Entry"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForwardIndentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Forward Indent",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Remarks
        const Text(
          "Remarks",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _remarksController,
          decoration: const InputDecoration(
            hintText: "Add your remarks here...",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),

        // Forward To
        const Text(
          "Forward To",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _forwardTo,
          decoration: const InputDecoration(
            hintText: "Select receiver",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          items: const [
            DropdownMenuItem(value: "hod", child: Text("Head of Department")),
            DropdownMenuItem(value: "director", child: Text("Director")),
            DropdownMenuItem(value: "finance", child: Text("Finance Department")),
          ],
          onChanged: (value) {
            setState(() {
              _forwardTo = value;
            });
          },
        ),
        const SizedBox(height: 16),

        // Receiver Designation
        const Text(
          "Receiver Designation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _receiverDesignation,
          decoration: const InputDecoration(
            hintText: "Select designation",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          items: const [
            DropdownMenuItem(value: "professor", child: Text("Professor")),
            DropdownMenuItem(value: "associate", child: Text("Associate Professor")),
            DropdownMenuItem(value: "assistant", child: Text("Assistant Professor")),
          ],
          onChanged: (value) {
            setState(() {
              _receiverDesignation = value;
            });
          },
        ),
        const SizedBox(height: 16),

        // Attachments
        const Text(
          "Attachments",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: _pickMultipleFiles,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade400),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ), child: null,
        ),
        if (_selectedFiles.isNotEmpty) ...[
          const SizedBox(height: 8),
          ..._selectedFiles.map((file) => ListTile(
            leading: Icon(file.type == 'image' ? Icons.image : Icons.insert_drive_file),
            title: Text(file.name),
            trailing: IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                setState(() {
                  _selectedFiles.remove(file);
                });
              },
            ),
          )),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: Colors.blue.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Archive Indent",
              style: TextStyle(color: Colors.blue.shade300, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class UploadFile {
  final File file;
  final String name;
  final String type;

  UploadFile({
    required this.file,
    required this.name,
    required this.type,
  });
}
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path/path.dart' as path;
// import 'dart:io';
//
// class IndentDetailScreen extends StatefulWidget {
//   const IndentDetailScreen({super.key});
//
//   @override
//   State<IndentDetailScreen> createState() => _IndentDetailScreenState();
// }
//
// class _IndentDetailScreenState extends State<IndentDetailScreen> {
//   final List<UploadFile> _selectedFiles = [];
//   final TextEditingController _remarksController = TextEditingController();
//   String? _forwardTo;
//   String? _receiverDesignation;
//
//   Future<void> _pickMultipleFiles() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.any,
//         allowMultiple: true,
//       );
//
//       if (result != null) {
//         setState(() {
//           for (PlatformFile platformFile in result.files) {
//             final uploadFile = UploadFile(
//               file: File(platformFile.path!),
//               name: platformFile.name,
//               type: _getFileType(platformFile),
//             );
//             _selectedFiles.add(uploadFile);
//           }
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('${result.files.length} file(s) selected'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking files: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   String _getFileType(PlatformFile file) {
//     final extension = file.extension?.toLowerCase() ?? '';
//     if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)) {
//       return 'image';
//     }
//     return 'document';
//   }
//
//   @override
//   void dispose() {
//     _remarksController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             const Icon(Icons.description, size: 24),
//             const SizedBox(width: 8),
//             const Text("Indent #10-Projector"),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Approval Section
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     _buildApprovalCircle(true),
//                     Container(
//                       width: 2,
//                       height: 40,
//                       color: Colors.blue,
//                     ),
//                     _buildApprovalCircle(true),
//                     Container(
//                       width: 2,
//                       height: 40,
//                       color: Colors.grey.shade300,
//                     ),
//                     _buildApprovalCircle(false),
//                   ],
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildSectionHeader("Head Approval"),
//                       _buildSectionContent("Department head approval status"),
//                       const SizedBox(height: 32),
//                       _buildSectionHeader("Director Approval"),
//                       _buildSectionContent("Director approval status"),
//                       const SizedBox(height: 32),
//                       _buildSectionHeader("Bill Approval"),
//                       _buildSectionContent("Financial clearance status"),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Description Section
//             _buildSectionHeader("Description"),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               color: Colors.grey.shade100,
//               child: const Text(
//                 "Computer",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Note Sheets and Attachments
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.description_outlined, size: 20),
//                     const SizedBox(width: 8),
//                     _buildSectionHeader("Note Sheets"),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.attach_file, size: 20),
//                     const SizedBox(width: 8),
//                     _buildSectionHeader("Attachments"),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Created By Section
//             _buildCreatedBySection(),
//             const SizedBox(height: 16),
//
//             // Indent Details
//             _buildIndentDetailsTable(),
//             const SizedBox(height: 24),
//
//             // Forward Indent Section
//             _buildForwardIndentSection(),
//             const SizedBox(height: 24),
//
//             // Action Buttons
//             _buildActionButtons(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildApprovalCircle(bool isApproved) {
//     return CircleAvatar(
//       radius: 12,
//       backgroundColor: isApproved ? Colors.blue : Colors.grey.shade300,
//       child: isApproved
//           ? const Icon(Icons.check, color: Colors.white, size: 16)
//           : const SizedBox(),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//         color: Colors.black,
//       ),
//     );
//   }
//
//   Widget _buildSectionContent(String content) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 4.0),
//       child: Text(
//         content,
//         style: TextStyle(
//           fontSize: 14,
//           color: Colors.grey.shade600,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCreatedBySection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Created by: -atul-professor"),
//             const SizedBox(height: 4),
//             Text(
//               "FILE ID: CSE-2024-02-#741",
//               style: TextStyle(color: Colors.grey.shade600),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildIndentDetailsTable() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           color: Colors.blue.shade50,
//           child: const Text(
//             "INDENT DETAILS",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Expanded(
//               flex: 2,
//               child: Text("Computer"),
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Text(
//                   "QTY1",
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             const Expanded(
//               child: Text(
//                 "₹4,525",
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text("Stock Entry"),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildForwardIndentSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Forward Indent",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//
//         // Remarks
//         const Text(
//           "Remarks",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: _remarksController,
//           decoration: const InputDecoration(
//             hintText: "Add your remarks here...",
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//           ),
//           maxLines: 3,
//         ),
//         const SizedBox(height: 16),
//
//         // Forward To
//         const Text(
//           "Forward To",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: _forwardTo,
//           decoration: const InputDecoration(
//             hintText: "Select receiver",
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//           ),
//           items: const [
//             DropdownMenuItem(value: "hod", child: Text("Head of Department")),
//             DropdownMenuItem(value: "director", child: Text("Director")),
//             DropdownMenuItem(value: "finance", child: Text("Finance Department")),
//           ],
//           onChanged: (value) {
//             setState(() {
//               _forwardTo = value;
//             });
//           },
//         ),
//         const SizedBox(height: 16),
//
//         // Receiver Designation
//         const Text(
//           "Receiver Designation",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: _receiverDesignation,
//           decoration: const InputDecoration(
//             hintText: "Select designation",
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//           ),
//           items: const [
//             DropdownMenuItem(value: "professor", child: Text("Professor")),
//             DropdownMenuItem(value: "associate", child: Text("Associate Professor")),
//             DropdownMenuItem(value: "assistant", child: Text("Assistant Professor")),
//           ],
//           onChanged: (value) {
//             setState(() {
//               _receiverDesignation = value;
//             });
//           },
//         ),
//         const SizedBox(height: 16),
//
//         // Attachments
//         const Text(
//           "Attachments",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         OutlinedButton(
//           onPressed: _pickMultipleFiles,
//           style: OutlinedButton.styleFrom(
//             side: BorderSide(color: Colors.grey.shade400),
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//           ),
//           child: const Text("Upload files"),
//         ),
//         if (_selectedFiles.isNotEmpty) ...[
//           const SizedBox(height: 8),
//           ..._selectedFiles.map((file) => ListTile(
//             leading: Icon(file.type == 'image' ? Icons.image : Icons.insert_drive_file),
//             title: Text(file.name),
//             trailing: IconButton(
//               icon: const Icon(Icons.close, color: Colors.red),
//               onPressed: () {
//                 setState(() {
//                   _selectedFiles.remove(file);
//                 });
//               },
//             ),
//           )),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildActionButtons() {
//     return Row(
//       children: [
//         Expanded(
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               "Submit",
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: OutlinedButton(
//             onPressed: () {},
//             style: OutlinedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               side: BorderSide(color: Colors.blue.shade300),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text(
//               "Archive Indent",
//               style: TextStyle(color: Colors.blue.shade300, fontSize: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class UploadFile {
//   final File file;
//   final String name;
//   final String type;
//
//   UploadFile({
//     required this.file,
//     required this.name,
//     required this.type,
//   });
// }