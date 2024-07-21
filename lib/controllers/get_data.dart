import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../helper/global.dart';

class GetDataController extends GetxController {
  static final fireStore = FirebaseFirestore.instance;

  static Future<bool> userExists({required String? uid}) async =>
      (await fireStore.collection("user").doc(uid).get()).exists;

  Stream getUser() =>
      FirebaseFirestore.instance.collection("user").doc(uid).snapshots();
}
