import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:hassana/controllers/settings_controller.dart';
import 'package:hassana/view/home/screens/edit_profile.dart';
import 'package:hassana/view/home/screens/about_screen.dart'; // Ensure this import points to your AboutScreen

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _imageFile;

  final SettingsController settingController = Get.put(SettingsController());

  User? user = FirebaseAuth.instance.currentUser;
  String userId = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    userId = user?.uid ?? 'unknown_user';
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display logged-in user's name
            Text(
              userName,
              style: const TextStyle(
                fontSize: 24, // Increased font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // User Profile Image with option to change
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : const AssetImage('assets/images/photo1.jpg') as ImageProvider,
                  child: _imageFile == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 32), // Increased spacing

            // Edit Profile
            ListTile(
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage(userId: userId)),
                );
              },
            ),
            const Divider(),

            // About
            ListTile(
              title: const Text('About'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            const Divider(),

            // Log Out
            ListTile(
              title: const Text('Log Out'),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () => settingController.logout(),
            ),
            const Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Share.share(
            'Check out our app at: <AppLink>',
            subject: 'Look what I made!',
          );
        },
        label: const Text('Share the App'), // Added label
        icon: const Icon(Icons.share),
      ),
    );
  }
}
