import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
