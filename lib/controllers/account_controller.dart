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
}
