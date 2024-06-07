import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:hassana/controllers/settings_controller.dart';
import 'package:hassana/view/home/screens/edit_profile.dart';
import 'package:hassana/view/home/screens/about_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      setState(() {
        userName = userDoc['name'] ?? 'User';
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

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
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Image with option to change
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : const AssetImage('assets/images/photo1.jpg')
                          as ImageProvider,
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
            const SizedBox(height: 16),

            // Display logged-in user's name
            Center(
              child: Text(
                userName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Edit Profile
            ListTile(
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward, color: Colors.black),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfilePage(userId: userId)),
                );
              },
            ),
            const Divider(color: Colors.grey),

            // About
            ListTile(
              title: const Text(
                'About',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward, color: Colors.black),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey),

            // Log Out
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.exit_to_app, color: Colors.black),
              onTap: () => settingController.logout(),
            ),
            const Divider(color: Colors.grey),
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
        label: const Text('Share the App'),
        icon: const Icon(Icons.share),
        backgroundColor: Colors.deepPurple[200],
      ),
    );
  }
}
