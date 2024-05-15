import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wigo/models/Trip.dart';
import 'package:wigo/providers/trip_provider.dart';

class ViewTripScreen extends StatelessWidget {
  late Trip trip;
  ViewTripScreen();

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    final tripId = currentPath.split('/').last;
    trip = Provider.of<TripProvider>(context).getTripById(int.parse(tripId));

    return Scaffold(
      appBar: AppBar(
        title: Text('View Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Title: ${trip.city}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Description: ${trip.budget}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${trip.startDate} - ${trip.endDate}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more trip details here if needed
          ],
        ),
      ),
    );
  }
}
