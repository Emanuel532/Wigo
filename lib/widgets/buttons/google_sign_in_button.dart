import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 35.0,
                    ),*/
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
