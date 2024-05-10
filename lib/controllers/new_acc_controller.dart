import 'package:wigo/services/authentication_service.dart';

class NewAccountController {
  final AuthenticationService _authenticationService;

  NewAccountController(this._authenticationService);

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
}
