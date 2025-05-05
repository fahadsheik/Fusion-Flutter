import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'secure_storage.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final SecureStorage secureStorage = SecureStorage();
  List<dynamic> pastEvents = [];
  List<dynamic> upcomingEvents = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final token = await secureStorage.read('auth_token');
      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found');
      }

      final headers = {'Authorization': 'Token $token'};

      final pastResponse = await http.get(
        Uri.parse('http://localhost:8000/gymkhana/past_events/'),
        headers: headers,
      );

      final upcomingResponse = await http.get(
        Uri.parse('http://localhost:8000/gymkhana/upcoming_events/'),
        headers: headers,
      );

      if (pastResponse.statusCode == 200 && upcomingResponse.statusCode == 200) {
        setState(() {
          pastEvents = json.decode(pastResponse.body);
          upcomingEvents = json.decode(upcomingResponse.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load events: ${pastResponse.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll('Exception: ', '');
        isLoading = false;
      });
    }
  }

  Widget buildEventCard(Map<String, dynamic> event) {
    final title = event['event_name'] ?? event['title'] ?? 'No Title';
    final date = event['start_date'] ?? event['date'] ?? 'No Date';
    final venue = event['venue'] ?? '';
    final desc = event['description'] ?? '';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: $date'),
            if (venue.isNotEmpty) Text('Venue: $venue'),
            if (desc.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(desc, maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget buildSection(String title, List<dynamic> events) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              )),
        ),
        const SizedBox(height: 12),
        if (events.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('No events found',
                style: TextStyle(color: Colors.grey)),
          ),
        ...events.map((event) => buildEventCard(event)).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.blue, width: 10)),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: fetchEvents,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildSection("Upcoming Events", upcomingEvents),
                          buildSection("Past Events", pastEvents),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}