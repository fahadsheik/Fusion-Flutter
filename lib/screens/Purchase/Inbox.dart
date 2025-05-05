import 'package:flutter/material.dart';
import 'indent_detail_screen.dart'; // Make sure to import your detail screen

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 3, // You can update this with actual message count
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow("File Id", "10"),
                _infoRow("Indent Item", "Projector"),
                _infoRow("Date", "15-02-2025"),
                const SizedBox(height: 8),
                Text(
                  "......",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    letterSpacing: 3,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _actionButton("View", Colors.blue.shade700, Colors.white, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IndentDetailScreen(),
                        ),
                      );
                    }),
                    const SizedBox(width: 12),
                    _actionButton("Delete", Colors.blue.shade700, Colors.white, () {
                      _showDeleteConfirmation(context);
                    }),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Item deleted")),
                );
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$label : $value',
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  Widget _actionButton(String label, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        minimumSize: const Size(100, 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 0,
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class InboxScreen extends StatelessWidget {
//   const InboxScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 3, // You can update this with actual message count
//       itemBuilder: (context, index) {
//         return Container(
//           margin: const EdgeInsets.only(bottom: 16),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: const Color(0xFFE6FAFB), // Light mint/blue background
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 6,
//                 offset: Offset(2, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _infoRow("File Id", "10"),
//               _infoRow("Indent Item", "Projector"),
//               _infoRow("Date", "15-02-2025"),
//               const SizedBox(height: 8),
//               const Text(
//                 "..............",
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   _actionButton("View", Colors.blue, Colors.white, () {
//                     // Handle View action
//                   }),
//                   const SizedBox(width: 12),
//                   _actionButton("Delete", Colors.red, Colors.white, () {
//                     // Handle Delete action
//                   }),
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _infoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: RichText(
//         text: TextSpan(
//           style: const TextStyle(fontSize: 15, color: Colors.black),
//           children: [
//             TextSpan(
//               text: "$label : ",
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             TextSpan(text: value),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _actionButton(String label, Color bgColor, Color textColor, VoidCallback onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: bgColor,
//         foregroundColor: textColor,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         elevation: 2,
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
