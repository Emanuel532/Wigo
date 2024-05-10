import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
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
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement sign in logic
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
              child: Text('Continue with Google'),
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
