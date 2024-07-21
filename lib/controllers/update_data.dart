import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../auth/model/user_model.dart';
import 'get_data.dart';
import "dart:developer";
import '../helper/global.dart';

class UpdateDataController extends GetxController {
  static final fb = FirebaseFirestore.instance;

  static Future<void> createUser(User? user) async {
    try {
      bool exists = await GetDataController.userExists(uid: user?.uid);
      log("user exists -->> $exists");

      if (!exists) {
        final userData = UserData(
            uid: uid,
            name: user?.displayName ?? "",
            emailId: user?.email ?? "",
            phoneNumber: user?.phoneNumber ?? "",
            photoUrl: user?.photoURL ?? "");

        await fb.collection("user").doc(uid).set(userData.toJson());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateFieldData(
      {required String key, required String value}) async {
    try {
      final doc = fb.collection("user").doc(uid);
      await doc.update({key: value});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateUserDetails({required Map<String, dynamic> data}) async {
    try {
      final doc = fb.collection("user").doc(uid);
      await doc.update(data);
      log('suucess');
      log('data -->> $data');
    } catch (e) {
      log(e.toString());
    }
  }
}
