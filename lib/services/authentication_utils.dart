import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationUtils {
  /// Checks if the user is authenticated.
  /// Returns `true` if the user is authenticated, `false` otherwise.
  static bool isUserAuthenticated() {
    bool isAuthenticated = true;
    if (FirebaseAuth.instance.currentUser == null) {
      isAuthenticated = false;
    }
    return isAuthenticated;
  }

  static User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }
}
