import 'package:flutter/material.dart';
import 'indent_detail_screen.dart'; // Make sure to import your detail screen

class AllFiledIndents extends StatefulWidget {
  const AllFiledIndents({super.key});

  @override
  _AllFiledIndentsState createState() => _AllFiledIndentsState();
}

class _AllFiledIndentsState extends State<AllFiledIndents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Filed Indents'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 3, // Number of indent items
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return _buildFiledIndentCard(context);
        },
      ),
    );
  }

  Widget _buildFiledIndentCard(BuildContext context) {
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
          // File ID
          Text(
            'File Id : 10',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),

          // Indent Item
          Text(
            'Indent Item : Projector',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),

          // Date
          Text(
            'Date : 15-02-2025',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),

          // Dotted line
          Text(
            '......',
            style: TextStyle(
              color: Colors.grey.shade400,
              letterSpacing: 3,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),

          // View button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to IndentDetailScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IndentDetailScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                minimumSize: const Size(100, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
              ),
              child: const Text('View'),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class AllFiledIndents extends StatefulWidget {
//   const AllFiledIndents({super.key});
//
//   @override
//   _AllFiledIndentsState createState() => _AllFiledIndentsState();
// }
//
// class _AllFiledIndentsState extends State<AllFiledIndents> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Purchase",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.lightBlue[50],
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     spreadRadius: 1,
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "File Id : 10",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     "Indent Item : Projector",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     "Date : 15-02-2025",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "..............\n..............",
//                     style: TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             _buildTextField("Remarks"),
//             SizedBox(height: 12),
//             _buildTextField("Forward To *"),
//             SizedBox(height: 12),
//             _buildTextField("Receiver Designation *"),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   side: BorderSide(color: Colors.blue),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: Text(
//                   "Forward",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 4),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: TextField(
//             decoration: InputDecoration(
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
