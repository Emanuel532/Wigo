import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Sign in with email and password.
  /// Returns a `UserCredential` if the sign in is successful, `null` otherwise.
  /// Throws an error if the sign in fails.
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  /// Sign up with email and password.
  /// Returns a `UserCredential` if the sign up is successful, `null` otherwise.
  ///  Throws an error if the sign up fails.
  ///
  /// TODO: save username in db
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  /// Sign out the current user.
  /// Returns `true` if the sign out is successful, `false` otherwise.
  ///   Throws an error if the sign out fails.
  ///
  static Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  //Sign in with Google account
  Future<UserCredential?> signInWithGoogle() async {}
}
