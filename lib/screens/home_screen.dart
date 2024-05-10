import 'package:flutter/material.dart';
import 'package:wigo/services/authentication_service.dart';
import 'package:wigo/services/authentication_utils.dart';

import 'package:wigo/widgets/buttons/generic_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wigo Trip Planner'),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Welcome to Wigo Tri Planner  ${AuthenticationUtils.currentUser?.uid} !',
                  style: TextStyle(fontSize: 24),
                ),
                GenericButton(
                  text: 'Sign Out',
                  onPressed: () {
                    AuthenticationService.signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
