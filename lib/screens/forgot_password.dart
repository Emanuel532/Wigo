import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wigo/controllers/account_controller.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/services/authentication_utils.dart';

import 'package:wigo/services/authentication_service.dart';
import 'package:wigo/widgets/email_input.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WIGO',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w800,
            fontSize: 36,
            color: const Color.fromARGB(255, 85, 157, 199),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Reset Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: const Color.fromARGB(255, 85, 157, 199),
                ),
              ),
              const SizedBox(height: 20.0),
              EmailInput(emailController: emailController),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Submit password reset request
                  if (emailController.text.isNotEmpty) {
                    AccountController(AuthenticationService())
                        .resetPassword(emailController.text)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Password reset email has been sent to ${emailController.text}'),
                        ),
                      );
                    }).catchError((err) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(err.toString()),
                        ),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter your email.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
