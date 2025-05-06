import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'secure_storage.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  final SecureStorage secureStorage = SecureStorage();
  List<dynamic> achievements = [];
  bool isLoading = true;
  bool isError = false;
  String errorMessage = '';

  final String clubName = "BitByte";

  @override
  void initState() {
    super.initState();
    fetchAchievements();
  }

  Future<void> fetchAchievements() async {
    try {
      final token = await secureStorage.read('auth_token');
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.post(
        Uri.parse('http://localhost:8000/gymkhana/api/show_achievement/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $token",
        },
        body: jsonEncode({"club_name": clubName}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          setState(() {
            achievements = data;
            isLoading = false;
          });
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load achievements: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
        errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.blue, width: 10)),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (isError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error: $errorMessage',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (achievements.isEmpty) {
      return const Center(child: Text('No achievements found'));
    }

    return RefreshIndicator(
      onRefresh: fetchAchievements,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                achievement['title'] ?? 'Untitled Achievement',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    achievement['achievement'] ?? 'No description available',
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (achievement['date'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Date: ${achievement['date']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}