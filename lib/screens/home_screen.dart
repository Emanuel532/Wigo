import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              //toDO: Add a list of trips here + design
              children: [
                Text(
                  'Welcome to Wigo Trip Planner  ${AuthenticationUtils.currentUser?.uid} !',
                  style: TextStyle(fontSize: 24),
                ),
                GenericButton(
                  text: 'Sign Out',
                  onPressed: () {
                    AuthenticationService.signOut();
                    // context.pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          GoRouter.of(context).go('/add-trip');
        },
      ),
    );
  }
}
