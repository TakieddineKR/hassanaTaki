import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/routes/app_routes.dart';
import 'add_request_controller.dart';
import 'home_page_controller.dart';
import 'login_controller.dart';
import 'signup_controller.dart';

class SettingsController extends GetxController {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.delete<HomePageController>();
    Get.delete<SettingsController>();
    Get.delete<LoginController>();
    Get.delete<SignUpController>();
    Get.delete<AddRequestController>();
    Get.offAndToNamed(AppRoute.login);
  }
}
