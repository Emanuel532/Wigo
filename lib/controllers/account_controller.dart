import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wigo/services/authentication_service.dart';

class AccountController {
  final AuthenticationService _authenticationService;

  AccountController(this._authenticationService);

  Future<void> createNewAccount(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await _authenticationService.signUpWithEmailAndPassword(
          email: email, password: password, username: username);
    } catch (e) {
      //TODO: handle error for creating new user
      throw e;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _authenticationService.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw e;
    }
  }

  //SignIn with Google logic
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // TODO: handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authenticationService.resetPassword(email);
    } catch (e) {
      throw e;
    }
  }
}
