import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hassana/models/user_model.dart';
import '../models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationHomeController extends GetxController {
  List<OrderModel> donationRequests = <OrderModel>[];
  List<OrderModel> filteredRequests = [];
  bool isLoadingDonation = true;
  bool isLoadingErrorDonation = false;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(filterList);
  }

  Future<UserModel> _fetchUser() async {
    // Fecth user
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final usersDocRef = FirebaseFirestore.instance.collection('users').doc(uid!);
    DocumentSnapshot<Object?> userDoc = await usersDocRef.get();
    final userModel = UserModel.fromJson(userDoc.data()! as Map<String, dynamic>);

    return userModel;
  }

  void filterList() {
    String query = searchController.text.toLowerCase();

    filteredRequests = donationRequests.where((request) {
      return request.userName.toLowerCase().contains(query);
    }).toList();
    update();
  }

  void fetchDonationRequests() async {
    // Fecth user
    isLoadingDonation = true;
    final userModel = await _fetchUser();

    String userType = userModel.userType;
    String collectionName = userType == 'ngo' ? 'restaurant_requests' : 'ngo_requests';

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionName).get();
      List<OrderModel> fetchedRequests = querySnapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      donationRequests = fetchedRequests;
      filteredRequests = fetchedRequests;
      isLoadingDonation = false;

      update();
    } catch (e) {
      isLoadingDonation = false;
      isLoadingErrorDonation = true;
      update();
      Get.snackbar('Error', 'Failed to fetch donation requests: $e');
    }
  }
}
