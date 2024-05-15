import 'package:flutter/material.dart';

class ItineraryBox extends StatelessWidget {
  final int days;

  const ItineraryBox({Key? key, required this.days}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: days,
      itemBuilder: (BuildContext context, int index) {
        // Adding 1 to index because days usually start from 1, not 0
        int dayNumber = index + 1;
        return ListTile(
          title: Text('Day $dayNumber'),
          subtitle: Text('bla bla bla bla'), // Replace with your content
        );
      },
    );
  }
}
