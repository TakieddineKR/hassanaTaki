import 'package:get/get.dart';
import '../models/order_model.dart';
import 'home_page_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationHistoryController extends GetxController {
  var donationRequests = <OrderModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonationRequests();
  }

  void fetchDonationRequests() async {
    HomePageController homePageController = Get.find<HomePageController>();

    if (homePageController.userInstance.isNotEmpty) {
      String userType = homePageController.userInstance.first.userType;
      String collectionName =
          userType == 'ngo' ? 'restaurant_requests' : 'ngo_requests';

      try {
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection(collectionName).get();
        List<OrderModel> fetchedRequests = querySnapshot.docs.map((doc) {
          return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        donationRequests.value = fetchedRequests;
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch donation requests: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.snackbar('Error', 'No user data available');
    }
  }
}
