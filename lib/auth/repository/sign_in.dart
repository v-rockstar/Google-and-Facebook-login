import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snapchat/controllers/update_data.dart';
import '../../helper/pref.dart';
import '../screens/my_homepage.dart';

class SignIn {
  final googleSignIn = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;

  void googleSignInfnc() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        final userCredentials =
            await firebaseAuth.signInWithCredential(credential);
        final user = userCredentials.user;
        log("gcredential -->> $user");

        Pref.uid = user?.uid;

        await UpdateDataController.createUser(user);

        Get.to(() => const MyHomePage());
      }
    } catch (e) {
      e.toString();
    }
  }

  void signOut() async {
    firebaseAuth.signOut();
    googleSignIn.signOut();
    Pref.box.clear();
  }

  void facebookLogin() async {
    try {
      LoginResult result = await FacebookAuth.instance.login();
      AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      final userCredentials =
          await firebaseAuth.signInWithCredential(credential);
      log("fbcredential -->> ${userCredentials.user}");
      Get.to(() => const MyHomePage());
    } on FirebaseAuthException catch (e) {
      log("error -->> ${e.toString()}");
    }
  }

  void fbSignOut() {
    firebaseAuth.signOut();
    FacebookAuth.i.logOut();
    Pref.box.clear();
  }
}
