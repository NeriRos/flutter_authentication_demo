import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth auth;

  Authentication(this.auth);

  User? get user => auth.currentUser;

  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      await showError(error, context);
    }
  }

  Future<void> sendEmailVerification() async {
    var user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      await showError(error, context);
    } catch (e) {
      if (e == 'email-already-in-use') {
        await showError('Email already in use.', context);
      }
    }
  }

  Future<void> authenticateWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      await showError(error, context);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  showError(error, BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error Occurred'),
        content: Text(error.toString()),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("OK"))
        ],
      ),
    );
  }
}
