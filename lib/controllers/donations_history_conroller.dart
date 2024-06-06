import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hassana/models/user_model.dart';
import '../models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationHistoryController extends GetxController {
  List<OrderModel> donationRequests = <OrderModel>[];
  bool isLoadingDonation = true;
  bool isLoadingErrorDonation = false;
  Future<UserModel> _fetchUser() async {
    // Fecth user
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final usersDocRef =
        FirebaseFirestore.instance.collection('users').doc(uid!);
    DocumentSnapshot<Object?> userDoc = await usersDocRef.get();
    final userModel =
        UserModel.fromJson(userDoc.data()! as Map<String, dynamic>);

    return userModel;
  }

  void fetchDonationRequests() async {
    isLoadingDonation = true;
    // Fecth user
    final userModel = await _fetchUser();

    String userType = userModel.userType;
    String collectionName =
        userType == 'ngo' ? 'restaurant_requests' : 'ngo_requests';

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();
      List<OrderModel> fetchedRequests = querySnapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      donationRequests = fetchedRequests;
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
