import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  var isLoading = true.obs;
  late String userId;

  ProfileController(String userId) {
    this.userId = userId;
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        organizationNameController.text = userData['name'] ?? '';
        locationController.text = userData['adress'] ?? '';
        phoneNumberController.text = userData['phoneNumber'] ?? '';
      } else {
        Get.snackbar('Error', 'User data not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  void applyModifications() async {
    isLoading(true);
    try {
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
      await userDoc.update({
        'name': organizationNameController.text,
        'adress': locationController.text,
        'phoneNumber': phoneNumberController.text,
        // Note: For password updates, you should handle this through Firebase Auth
      });
      if (passwordController.text.isNotEmpty) {
        await FirebaseAuth.instance.currentUser!.updatePassword(passwordController.text);
      }
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    organizationNameController.dispose();
    locationController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
