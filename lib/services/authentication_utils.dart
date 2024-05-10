import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationUtils {
  /// Checks if the user is authenticated.
  /// Returns `true` if the user is authenticated, `false` otherwise.
  static bool isUserAuthenticated() {
    bool isAuthenticated = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isAuthenticated = false;
      } else {
        isAuthenticated = true;
      }
    });
    return isAuthenticated;
  }
}
