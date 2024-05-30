import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/routes/app_routes.dart';
import '../core/services/loading_service.dart';
import '../models/user_model.dart';
import 'login_controller.dart';

class SignUpController extends GetxController {
  GlobalKey<FormState> signUpformstate = GlobalKey<FormState>();

  int radioValue = 1;
  late String emailController;
  late String usernameController;
  late String passwordController;
  late String confirmpasswordController;
  late String adressController;
  late String phoneController;

  void navToLogin() {
    Get.delete<SignUpController>();
    Get.delete<LoginController>();
    Get.offAndToNamed(AppRoute.login);
  }

  Future<void> signUp() async {
    FormState? formdata = signUpformstate.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        LoadingService().showLoading();
        try {
          UserCredential credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController,
            password: passwordController,
          );
          UserModel newUser = UserModel(
            name: usernameController,
            userEmail: emailController,
            userType: radioValue == 1 ? 'ngo' : 'restaurant',
            adress: adressController,
            phoneNumber: phoneController,
            userId: credential.user!.uid,
          );

          DocumentReference<Map<String, dynamic>> userCollection =
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(credential.user!.uid);
          await userCollection.set(newUser.toJson());
          LoadingService().dismissLoading();
          Get.offAllNamed(AppRoute.navbar);
          LoadingService().showSuccess('welcome');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            LoadingService().showError('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            LoadingService()
                .showError('The account already exists for that email.');
          }
        } catch (e) {
          return;
        }
      }
    }
  }
}
