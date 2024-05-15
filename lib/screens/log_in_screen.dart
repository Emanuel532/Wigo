import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wigo/controllers/account_controller.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/services/authentication_utils.dart';

import 'package:wigo/services/authentication_service.dart';
import 'package:wigo/widgets/email_input.dart';
import 'package:wigo/widgets/buttons/google_sign_in_button.dart';
import 'package:wigo/widgets/password_input.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WIGO',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w800,
            fontSize: 100,
            color: Color.fromARGB(255, 85, 157, 199),
          ),
        ),
        toolbarHeight: 90,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Sign in',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w600,
                      fontSize: 64,
                      color: Color.fromARGB(255, 85, 157, 199),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.0),
              EmailInput(
                emailController: emailController,
              ),
              SizedBox(height: 16.0),
              PasswordInput(
                passwordController: passwordController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          // Disables the hover animation
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.transparent;
                          }
                          return null; // Use the default color
                        },
                      ),
                    ),
                    child: Text(
                      'Forgot your password?',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color.fromARGB(255, 85, 157, 199),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              //todo: ADD A loading progress indicator
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Sign in or login
                      if (!emailController.text.isEmpty &&
                          !passwordController.text.isEmpty) {
                        AccountController(AuthenticationService())
                            .signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        )
                            .then((_) {
                          if (AuthenticationUtils.isUserAuthenticated()) {
                            Provider.of<TripProvider>(context, listen: false)
                                .loadTripsFromDatabase();
                            GoRouter.of(context).pushReplacement('/');
                          }
                        }).catchError((err) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(err.toString()),
                            ),
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 85, 157, 199),
                      foregroundColor: Colors.white,
                      elevation: 3,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Log in',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'or',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      color: Color.fromARGB(255, 85, 157, 199),
                    ),
                  ),
                  SizedBox(height: 10),
                  GoogleSignInButton(
                    contextt: context,
                  ),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
