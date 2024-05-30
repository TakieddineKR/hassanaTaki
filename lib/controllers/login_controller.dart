import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/routes/app_routes.dart';
import '../core/services/loading_service.dart';

class LoginController extends GetxController {
  late String emailController;
  late String passwordController;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  void navToSignup() => Get.toNamed(AppRoute.signUp);
  Future<void> login() async {
    FormState? formdata = formstate.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        LoadingService().showLoading();
        try {
          UserCredential credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController,
            password: passwordController,
          );
          LoadingService().dismissLoading();
          Get.offAllNamed(AppRoute.navbar);
        } on FirebaseAuthException catch (error) {
          if (error.code == 'user-not-found') {
            LoadingService().dismissLoading();
            LoadingService().showError('No user found for that email.');
          } else if (error.code == 'wrong-password') {
            LoadingService().dismissLoading();
            LoadingService()
                .showError('Wrong password provided for that user.');
          }
        }
      }
    }
  }
}
