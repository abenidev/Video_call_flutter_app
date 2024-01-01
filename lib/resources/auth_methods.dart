import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_chat_app/constants/strings.dart';
import 'package:video_chat_app/models/user.dart';
import 'package:video_chat_app/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool resp = false;

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return resp;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          await _firestore.collection("users").doc(user.uid).set(
                CUser(
                  username: user.displayName ?? '',
                  uid: user.uid,
                  profilePhoto: user.photoURL ?? '',
                ).toMap(),
              );
        }
        resp = true;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('e: ${e}');
      if (context.mounted) {
        showSnackBar(context, e.message ?? commonError);
      }
    }

    return resp;
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('e: ${e}');
    }
  }
}
