import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wigo/controllers/account_controller.dart';
import 'package:wigo/services/authentication_service.dart';
import 'package:wigo/services/authentication_utils.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  BuildContext contextt;
  GoogleSignInButton({required this.contextt});

  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 85, 157, 199), // background color
                  foregroundColor: Colors.white, // text color
                  elevation: 3, // elevation
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // button padding
                  shape: RoundedRectangleBorder( // button border
                    borderRadius: BorderRadius.circular(5),
                    ),
                  ),
        onPressed: () async {
          setState(() {
            _isSigningIn = true;
          });

          User? user =
              await AccountController.signInWithGoogle(context: context)
                  .then((value) {
            //print(AuthenticationUtils.isUserAuthenticated());
            if (AuthenticationUtils.isUserAuthenticated()) {
              print('se executa eventual');
              GoRouter.of(this.widget.contextt).pushReplacement('/');
            }
          });

          setState(() {
            _isSigningIn = false;
          });

          print('User: $user');
          print('blabla123');
          if (user != null) {
            //todo: fix GoRouter navigation
            print('User: inauntru $user');
            //GoRouter.of(this.widget.contextt).go('/');
            /*Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          },
      ),
    );*/
          }
        },

                child: Text('Continue with Google',
              style: GoogleFonts.raleway(
                fontWeight:FontWeight.w400,
                fontSize: 26,
                color: Color.fromARGB(255, 255, 255, 255)
              ),
              
            
          
        
      ),
      ),
    );
  }
}
