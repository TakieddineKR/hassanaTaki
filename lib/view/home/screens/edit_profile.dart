import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/edite_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  final String? userId; // userId can be null

  const EditProfilePage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    if (userId == null) return const Text('Error: No user ID provided');

    ProfileController profileController = Get.put(ProfileController(userId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Organization Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: profileController.organizationNameController,
                    decoration: const InputDecoration(
                        labelText: 'Name', prefixIcon: Icon(Icons.business)),
                  ),
                  const SizedBox(height: 16),
                  const Text('Location',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: profileController.locationController,
                    decoration: const InputDecoration(
                        labelText: 'Location',
                        prefixIcon: Icon(Icons.location_on)),
                  ),
                  const SizedBox(height: 16),
                  const Text('Phone Number',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: profileController.phoneNumberController,
                    decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone)),
                  ),
                  const SizedBox(height: 16),
                  const Text('Password',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: profileController.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: profileController.applyModifications,
                    child: const Text('Apply Modifications'),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
