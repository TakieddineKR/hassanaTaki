import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/edite_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  final String? userId; // userId can be null

  EditProfilePage({this.userId});

  @override
  Widget build(BuildContext context) {
    if (userId == null) return Text('Error: No user ID provided');

    ProfileController profileController = Get.put(ProfileController(userId!));

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Organization Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: profileController.organizationNameController,
                    decoration: InputDecoration(
                        labelText: 'Name', prefixIcon: Icon(Icons.business)),
                  ),
                  SizedBox(height: 16),
                  Text('Location',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: profileController.locationController,
                    decoration: InputDecoration(
                        labelText: 'Location',
                        prefixIcon: Icon(Icons.location_on)),
                  ),
                  SizedBox(height: 16),
                  Text('Phone Number',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: profileController.phoneNumberController,
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone)),
                  ),
                  SizedBox(height: 16),
                  Text('Password',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: profileController.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: profileController.applyModifications,
                    child: Text('Apply Modifications'),
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
