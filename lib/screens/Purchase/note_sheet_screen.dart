import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class NoteSheetScreen extends StatefulWidget {
  const NoteSheetScreen({super.key});

  @override
  State<NoteSheetScreen> createState() => _NoteSheetScreenState();
}

class _NoteSheetScreenState extends State<NoteSheetScreen> {
  final List<UploadFile> _selectedFiles = [];
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _receiverController = TextEditingController();

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
    _receiverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note Sheets and Attachments Buttons (for context, not functional here)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.description_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "Note Sheets",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.attach_file, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      "Attachments",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Created by and File ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Created by: atul-professor"),
                Text(
                  "FILE ID: CSE-2027-09-#6710",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Form Fields as Label-Value Pairs
            _buildLabelValueRow("SUBJECT:", "--"),
            _buildLabelValueRow("NAME:", "2"),
            _buildLabelValueRow("QUANTITY:", "40"),
            _buildLabelValueRow("SUBTYPE:", "Subtype"),
            _buildLabelValueRow("PURPOSE:", "new"),
            _buildLabelValueRow("TYPE:", "EQUIPMENT"),
            _buildLabelValueRow("ITEM NATURE:", "Consumable"),
            _buildLabelValueRow("INDIGENOUS:", "YES"),
            _buildLabelValueRow("REPLACED:", "YES"),
            _buildLabelValueRow("BUDGETARY HEAD:", "sdfsf"),
            _buildLabelValueRow("HEAD APPROVAL:", "YES"),
            _buildLabelValueRow("DIRECTOR APPROVAL:", "NO"),
            _buildLabelValueRow("EXPECTED DELIVERY:", "Oct 1,2024"),
            _buildLabelValueRow("SOURCES OF SUPPLY:", "sfnsfn"),
            _buildLabelValueRow("FINANCIAL APPROVAL:", "NO"),
            _buildLabelValueRow("PURCHASED:", "NO"),
            _buildLabelValueRow("RECEIVED BY:", "vkjain-HOD(CSE)"),
            const SizedBox(height: 8),
            const Text(
              "Atul-Professor: Sent by atul on 10/10/2014 8:19 pm. File with id:619 created by atul and sent to vkjain vkjain-HOD(CSE)",
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),

            // Remarks Section
            const Text(
              "REMARKS:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _remarksController,
              decoration: InputDecoration(
                hintText: "nice",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Receiver Section
            const Text(
              "RECEIVER:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _receiverController,
              decoration: InputDecoration(
                hintText: "psadmin - adesh",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
            const SizedBox(height: 16),

            // Attachments Section
            const Text(
              "ATTACH FILES:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _pickMultipleFiles,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
              child: const Text("Choose File"),
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
            ] else ...[
              const SizedBox(height: 8),
              const Text("ABC.pdf"),
            ],
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Archive",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Send",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelValueRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
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
// // note_sheet_screen.dart
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
//
// class NoteSheetScreen extends StatefulWidget {
//   const NoteSheetScreen({super.key});
//
//   @override
//   State<NoteSheetScreen> createState() => _NoteSheetScreenState();
// }
//
// class _NoteSheetScreenState extends State<NoteSheetScreen> {
//   final List<UploadFile> _selectedFiles = [];
//   final TextEditingController _remarksController = TextEditingController();
//   final TextEditingController _receiverController = TextEditingController();
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
//     _receiverController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Note Sheets and Attachments Buttons (for context, not functional here)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.description_outlined, size: 20),
//                     const SizedBox(width: 8),
//                     Text(
//                       "Note Sheets",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.attach_file, size: 20),
//                     const SizedBox(width: 8),
//                     const Text(
//                       "Attachments",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Created by and File ID
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Created by: atul-professor"),
//                 Text(
//                   "FILE ID: CSE-2027-09-#6710",
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Form Fields as Label-Value Pairs
//             _buildLabelValueRow("SUBJECT:", "--"),
//             _buildLabelValueRow("NAME:", "2"),
//             _buildLabelValueRow("QUANTITY:", "40"),
//             _buildLabelValueRow("SUBTYPE:", "Subtype"),
//             _buildLabelValueRow("PURPOSE:", "new"),
//             _buildLabelValueRow("TYPE:", "EQUIPMENT"),
//             _buildLabelValueRow("ITEM NATURE:", "Consumable"),
//             _buildLabelValueRow("INDIGENOUS:", "YES"),
//             _buildLabelValueRow("REPLACED:", "YES"),
//             _buildLabelValueRow("BUDGETARY HEAD:", "sdfsf"),
//             _buildLabelValueRow("HEAD APPROVAL:", "YES"),
//             _buildLabelValueRow("DIRECTOR APPROVAL:", "NO"),
//             _buildLabelValueRow("EXPECTED DELIVERY:", "Oct 1,2024"),
//             _buildLabelValueRow("SOURCES OF SUPPLY:", "sfnsfn"),
//             _buildLabelValueRow("FINANCIAL APPROVAL:", "NO"),
//             _buildLabelValueRow("PURCHASED:", "NO"),
//             _buildLabelValueRow("RECEIVED BY:", "vkjain-HOD(CSE)"),
//             const SizedBox(height: 8),
//             const Text(
//               "Atul-Professor: Sent by atul on 10/10/2014 8:19 pm. File with id:619 created by atul and sent to vkjain vkjain-HOD(CSE)",
//               style: TextStyle(fontSize: 12),
//             ),
//             const SizedBox(height: 16),
//
//             // Remarks Section
//             const Text(
//               "REMARKS:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _remarksController,
//               decoration: InputDecoration(
//                 hintText: "nice",
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//
//             // Receiver Section
//             const Text(
//               "RECEIVER:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _receiverController,
//               decoration: InputDecoration(
//                 hintText: "psadmin - adesh",
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Attachments Section
//             const Text(
//               "ATTACH FILES:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             OutlinedButton(
//               onPressed: _pickMultipleFiles,
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(color: Colors.grey.shade400),
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//               ),
//               child: const Text("Choose File"),
//             ),
//             if (_selectedFiles.isNotEmpty) ...[
//               const SizedBox(height: 8),
//               ..._selectedFiles.map((file) => ListTile(
//                 leading: Icon(file.type == 'image' ? Icons.image : Icons.insert_drive_file),
//                 title: Text(file.name),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       _selectedFiles.remove(file);
//                     });
//                   },
//                 ),
//               )),
//             ] else ...[
//               const SizedBox(height: 8),
//               const Text("ABC.pdf"),
//             ],
//             const SizedBox(height: 16),
//
//             // Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Archive",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue.shade700,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Send",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLabelValueRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(value),
//         ],
//       ),
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