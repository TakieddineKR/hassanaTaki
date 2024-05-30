import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../core/enums/order_status_enum.dart';
import '../core/services/loading_service.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';
import 'home_page_controller.dart';

class AddRequestController extends GetxController {
  GlobalKey<FormState> requestFormKey = GlobalKey<FormState>();

  //? HOME PAGE CONTROLLER
  static final HomePageController homePageController =
      Get.find<HomePageController>();
  UserModel userModel = homePageController.userInstance.first;

  //! FIELDS
  late String description;
  late int quantity;
  late String location;
  late String phoneNumber;
  DateTime date = DateTime.now();
  bool deliveryEmployeeAvailable = true;

  //!! UUID
  Uuid uuid = const Uuid();

  Future<void> addRequest() async {
    FormState? formdata = requestFormKey.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        LoadingService().showLoading();

        // Determine the collection name based on the user type
        String collectionName = userModel.userType == 'ngo'
            ? 'ngo_requests'
            : 'restaurant_requests';
        CollectionReference requests =
            FirebaseFirestore.instance.collection(collectionName);

        String orderId = uuid.v4();
        OrderModel newRequest = OrderModel(
          //! USER ID
          orderId: orderId,
          //! FIELDS FROM UI
          orderDescription: description,
          orderAmount: quantity,
          orderAddress: location,
          orderPhone: phoneNumber,
          orderDate: date,
          hasEmployee: deliveryEmployeeAvailable,
          //! NOT FROM UI
          userName: userModel.name,
          orderUser: userModel.userType,
          orderStatus: OrderStatusEnum.pending.name,
        );

        try {
          await requests.doc(orderId).set(newRequest.toJson());
          LoadingService().dismissLoading();
          Get.back();
        } on FirebaseException catch (e) {
          LoadingService().dismissLoading();
          Get.snackbar('Error', 'Failed to add request: ${e.message}');
        }
      }
    }
  }
}
