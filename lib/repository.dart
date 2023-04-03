import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Repository {
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  void googleSignInfnc() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      e.toString();
    }
  }

  void signOut() async {
    firebaseAuth.signOut();
    googleSignIn.signOut();
  }

  void facebookLogin() async {
    try {
      LoginResult result = await FacebookAuth.instance.login();
      AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
  }

  void fbSignOut() {
    firebaseAuth.signOut();
    FacebookAuth.i.logOut();
  }
}
