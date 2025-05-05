import 'package:flutter/material.dart';
import 'add.dart';
import 'ge.dart';
import 'remove.dart';
import 'academics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fusion Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const AcademicsModuleScreen(),
      routes: {
        '/ge': (context) => const RollListPage(),
        '/add': (context) => const AddCourseScreen(),
        '/remove': (context) => const RemoveCourseScreen(),
        '/module': (context) => const AcademicsModuleScreen(),
      },
    );
  }
}

class AcademicsModuleScreen extends StatelessWidget {
  const AcademicsModuleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Avijit Biswas',
                      style: TextStyle(
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Acad Admin',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
                IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.blue, width: 1),
              ),
              child: Center(
                child: Text(
                  'Academics Module',
                  style: TextStyle(
                    color: Colors.blue[500],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildActionItem(context, 'Generate Roll List'),
                _buildActionItem(context, 'Add Courses'),
                _buildActionItem(context, 'Remove Courses'),
                _buildActionItem(context, 'Manage Schedule'),
                _buildActionItem(context, 'View Student Registration'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String title) {
    String? route;
    switch (title) {
      case 'Generate Roll List':
        route = '/ge';
        break;
      case 'Add Courses':
        route = '/add';
        break;
      case 'Remove Courses':
        route = '/remove';
        break;
      default:
        route = null;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.chevron_right),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        onTap: route != null ? () => Navigator.pushNamed(context, route!) : null,
      ),
    );
  }
}
