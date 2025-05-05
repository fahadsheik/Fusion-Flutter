import 'package:flutter/material.dart';

class FestPage extends StatelessWidget {
  const FestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fests'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFestCard(
              title: 'Tarang',
              image: 'assets/Tarang.png',
              color: Colors.lightBlueAccent,
              description:
                  'Tarang is our college’s vibrant annual fest, organized by cultural clubs, showcasing a blend of music, dance, drama, and artistic performances. It brings together students to celebrate creativity through competitions, workshops, and live shows, fostering talent and cultural exchange.',
            ),
            const SizedBox(height: 20),
            _buildFestCard(
              title: 'Abhikalpan',
              image: 'assets/Abhikalpan.png',
              color: Colors.lightGreenAccent.shade100,
              description:
                  'ABHIKALPAN is the annual technical fest of IIITDM Jabalpur, an institute which boasts of technical superiority and innovation in what it builds. It’s central India’s biggest technical extravaganza for creating, nurturing and fueling one’s interest in computer science, robotics, electronics, gaming and design.',
            ),
            const SizedBox(height: 20),
            _buildFestCard(
              title: 'Gusto',
              image: 'assets/Gusto.png',
              color: Colors.deepPurple.shade100,
              description:
                  'Gusto is our college’s thrilling annual sports fest, organized by the sports clubs, bringing together athletes for intense competitions and team spirit. It features football, basketball, cricket, athletics, and more, fostering sportsmanship and healthy competition.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFestCard({
    required String title,
    required String image,
    required Color color,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 1, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
