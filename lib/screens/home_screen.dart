import 'package:flutter/material.dart';

import 'package:wigo/services/authentication_utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (AuthenticationUtils.isUserAuthenticated()) {
      print('User is authenticated');
    } else {
      print('User is not authenticated');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Wigo Trip Planner'),
      ),
      body: Center(
        child: Text(
          'Welcome to Wigo Tri Planner!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
