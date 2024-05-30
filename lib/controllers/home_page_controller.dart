import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class HomePageController extends GetxController {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');
  List<UserModel> userInstance = [];
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  Future<void> fetchUser() async {
    userInstance.clear();
    DocumentSnapshot<Object?> userDocs =
        await _usersRef.doc(_currentUser!.uid).get();
    Map<String, dynamic> userData = userDocs.data() as Map<String, dynamic>;
    userInstance.add(UserModel.fromJson(userData));
    update();
    print(userInstance.first.name);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }
}
