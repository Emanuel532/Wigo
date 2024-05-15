import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wigo/controllers/account_controller.dart';
import 'package:wigo/services/authentication_service.dart';

import '../widgets/email_input.dart';
import '../widgets/password_input.dart';
import '../widgets/username_input.dart';

class CreateAccountScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WIGO',
              style: GoogleFonts.raleway(
                fontWeight:FontWeight.w800,
                fontSize: 100,
                color: Color.fromARGB(255, 85, 157, 199)
              ),
        ),
        toolbarHeight: 90,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('Sign up',
                  style: GoogleFonts.raleway(
                    fontWeight:FontWeight.w600,
                    fontSize: 64,
                    color: Color.fromARGB(255, 85, 157, 199),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.0),
            UsernameInput(usernameController: usernameController),
            SizedBox(height: 16.0),
            EmailInput(emailController: emailController,),
            SizedBox(height: 16.0),
            PasswordInput(passwordController: passwordController,),
            SizedBox(height: 32.0),
            
            ElevatedButton(
              onPressed: () {
                // check if all input fields are filled
                // if not, show an error message
                // if all fields are filled, create the account
                if (usernameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  print('s');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                } else {
                  // create the account
                  AccountController(AuthenticationService())
                      .createNewAccount(
                    username: usernameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  )
                      .then((value) {
                    print('Account created');
                    GoRouter.of(context).push('/');
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error creating account: $e'),
                      ),
                    );
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 85, 157, 199), // background color
                  foregroundColor: Colors.white, // text color
                  elevation: 3, // elevation
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // button padding
                  shape: RoundedRectangleBorder( // button border
                    borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Create an account',
                  style: GoogleFonts.raleway(
                        fontWeight:FontWeight.w400,
                        fontSize: 32,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),),
            ),
          ],
        ),
      ),
    );
  }
}
