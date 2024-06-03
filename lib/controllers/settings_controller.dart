import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/routes/app_routes.dart';

class SettingsController extends GetxController {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.deleteAll(force: true);
    Get.offAndToNamed(AppRoute.login);
  }
}
