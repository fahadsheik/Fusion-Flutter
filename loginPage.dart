import 'package:flutter/material.dart';

class FusionLoginPage extends StatelessWidget {
  const FusionLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Text("Fusion"),
            const Spacer(),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.notifications_none), onPressed: () {}),
            PopupMenuButton(
                itemBuilder: (context) => [
                      const PopupMenuItem(child: Text("Option 1")),
                      const PopupMenuItem(child: Text("Option 2")),
                    ]),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/logo.png', // Place your logo in assets
                height: 150,
              ),
              const SizedBox(height: 20),
              Text(
                "Fusion Login",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "College Community Application",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "lets make your college experience a breeze",
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 32),
              // Username Field
              _buildTextField(hintText: "22bcsi01"),
              const SizedBox(height: 16),
              // Password Field
              _buildTextField(hintText: "Password", obscure: true),
              const SizedBox(height: 32),
              // Login Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration');
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText, bool obscure = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class FusionLoginPage extends StatelessWidget {
//   const FusionLoginPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(), // For the hamburger menu
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Row(
//           children: [
//             Text("Fusion"),
//             Spacer(),
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: Icon(Icons.notifications_none),
//               onPressed: () {},
//             ),
//             PopupMenuButton(
//               itemBuilder: (context) => [
//                 PopupMenuItem(child: Text("Option 1")),
//                 PopupMenuItem(child: Text("Option 2")),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               Image.asset(
//                 'assets/logo.png', // Make sure this asset is added in pubspec.yaml
//                 height: 150,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Fusion Login",
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue[800],
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "College Community Application",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.blue[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 "lets make your college experience a breeze",
//                 style: TextStyle(color: Colors.grey[700]),
//               ),
//               SizedBox(height: 32),
//               // Username Field
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "22bcsi01",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               // Password Field
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 32),
//               // Login Button
//               SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton(
//                   onPressed: () {},
//                   child: Text(
//                     "Login",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     side: BorderSide(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Forgot Password?",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
