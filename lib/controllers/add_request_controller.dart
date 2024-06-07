import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../core/enums/order_status_enum.dart' as core_enums;
import '../core/services/loading_service.dart';
import '../models/order_model.dart' as model;
import '../models/user_model.dart';

class AddRequestController extends GetxController {
  GlobalKey<FormState> requestFormKey = GlobalKey<FormState>();

  //? HOME PAGE CONTROLLER

  //! FIELDS
  late String description;
  late int quantity;
  late String location;
  late String phoneNumber;
  DateTime date = DateTime.now();
  RxBool deliveryEmployeeAvailable = true.obs;

  //!! UUID
  Uuid uuid = const Uuid();

  Future<UserModel> _fetchUser() async {
    // Fetch user
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final usersDocRef =
        FirebaseFirestore.instance.collection('users').doc(uid!);
    DocumentSnapshot<Object?> userDoc = await usersDocRef.get();
    final userModel =
        UserModel.fromJson(userDoc.data()! as Map<String, dynamic>);

    return userModel;
  }

  Future<void> addRequest() async {
    FormState? formdata = requestFormKey.currentState;

    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        LoadingService().showLoading();

        // Fetch user
        final userModel = await _fetchUser();

        // Determine the collection name based on the user type
        String collectionName = userModel.userType == 'ngo'
            ? 'ngo_requests'
            : 'restaurant_requests';
        CollectionReference requests =
            FirebaseFirestore.instance.collection(collectionName);

        String orderId = uuid.v4();
        model.OrderModel newRequest = model.OrderModel(
          //! USER ID
          orderId: orderId,
          //! FIELDS FROM UI
          orderDescription: description,
          orderAmount: quantity,
          orderAddress: location,
          orderPhone: phoneNumber,
          orderDate: date,
          hasEmployee: deliveryEmployeeAvailable.value,
          //! NOT FROM UI
          userName: userModel.name,
          orderUser: userModel.userType,
          orderStatus: core_enums.OrderStatusEnum.pending,
        );

        try {
          await requests.doc(orderId).set(newRequest.toJson());

          LoadingService().dismissLoading();
          LoadingService().showSuccess("Added");
          Get.back();
        } on FirebaseException catch (e) {
          LoadingService().dismissLoading();
          Get.snackbar('Error', 'Failed to add request: ${e.message}');
        }
      }
    }
  }
}
