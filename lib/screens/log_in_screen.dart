import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wigo/controllers/account_controller.dart';
import 'package:wigo/services/authentication_utils.dart';

import 'package:wigo/services/authentication_service.dart';
import 'package:wigo/widgets/buttons/google_sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            //todo: ADD A loading progress indicator
            ElevatedButton(
              onPressed: () {
                //sigin login
                if (!emailController.text.isEmpty &&
                    !passwordController.text.isEmpty) {
                  AccountController(AuthenticationService())
                      .signIn(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((_) {
                    if (AuthenticationUtils.isUserAuthenticated()) {
                      GoRouter.of(context).pushReplacement('/');
                    }
                    ;
                  }).catchError((err) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(err.toString()),
                      ),
                    );
                  });
                }
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // goRoute that takes the user to the new account creation screen
                GoRouter.of(context).go('/login/create_account');
              },
              child: Text('Create New Account'),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // TODO: Implement continue with Google logic
              },
              child: GoogleSignInButton(
                contextt: context,
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // TODO: Implement forgot password logic
              },
              child: Text('Forgot your password?'),
            ),
          ],
        ),
      ),
    );
  }
}
