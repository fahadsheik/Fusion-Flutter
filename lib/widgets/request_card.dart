import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String date;
  final String duration;
  final String status;
  final String info;
  final Color color;

  const RequestCard({
    super.key,
    required this.date,
    required this.duration,
    required this.status,
    required this.info,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: $date",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Duration: $duration"),
            Text("Payment Status: $status",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Additional Info: $info"),
          ],
        ),
      ),
    );
  }
}
