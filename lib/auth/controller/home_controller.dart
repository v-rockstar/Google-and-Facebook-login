// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:snapchat/auth/model/user_model.dart';
// import 'package:snapchat/controllers/get_data.dart';
// import '../../helper/global.dart';

// class HomeController extends GetxController {
//   final userData = UserData().obs;
//   final isLoaded = false.obs;



//   // Future<UserData?> getUser() async {
//   //   final data = await GetDataController.getDocData(
//   //       collectionPath: "user", docId: uid ?? "");

//   //   if (data != null) {
//   //     userData.value = UserData.fromJson(data);
//   //     log("getuserdata -->> ${userData.value.phoneNumber}");
//   //     isLoaded.value = true;
//   //     return userData.value;
//   //   } else {
//   //     isLoaded.value = false;
//   //     log("No data available");
//   //     return null;
//   //   }
//   // }
// }
