import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Name
            const Text(
              'HASSANA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 0, 0, 0),
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black26,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // App Version
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32),

            // Description
            const Text(
              'This app is designed to help NGOs and Restaurants manage their profiles and perform various tasks efficiently. The app offers features such as profile editing, viewing organization details, and more.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // Developers
            const Text(
              'Developers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Developer KRAOUAS TAKIEDDINE',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // Contact Information
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email: Takikraouas@gmail.com\nPhone: +213 555 92 82 75',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
