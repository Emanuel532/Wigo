import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_client/unsplash_client.dart';
import 'package:wigo/controllers/trip_controller.dart';
import 'package:wigo/models/Trip.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/widgets/buttons/accommodation_button.dart';
import 'package:wigo/widgets/itinerary.dart';

final Color blue = Color.fromARGB(255, 85, 157, 199);

String formatDateTime(DateTime dateTime) {
  // Define the format pattern
  final DateFormat formatter = DateFormat('dd MMM yyyy');

  // Format the DateTime object
  return formatter.format(dateTime).toUpperCase();
}

class ViewTripScreen extends StatelessWidget {
  late Trip trip;
  ViewTripScreen();

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    final tripId = currentPath.split('/').last;
    trip = Provider.of<TripProvider>(context, listen: false)
        .getTripById(int.parse(tripId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your trip',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                trip.photo,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text(
                'Trip to ${trip.city}',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w400,
                  fontSize: 60,
                  color: blue,
                ),
              ),
              Divider(
                color: blue,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'From ${formatDateTime(trip.startDate)} until ${formatDateTime(trip.endDate)}.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: blue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Budget: ${trip.budget}',
                style: TextStyle(
                    fontSize: 18, color: blue, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              Text('Trip status: ${trip.isPublic ? 'Public' : 'Private'}',
                  style: TextStyle(
                      fontSize: 18, color: blue, fontWeight: FontWeight.w400)),
              Text(
                'Invite code: ${trip.inviteCode}',
                style: TextStyle(
                    fontSize: 18, color: blue, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Divider(
                color: blue,
              ),
              Text(
                'Itinerary',
                style: TextStyle(
                    fontSize: 48, color: blue, fontWeight: FontWeight.w400),
              ),
              ItineraryBox(
                itineraryItems: trip.itinerary,
              ),
              SizedBox(height: 10),
              Center(
                  child: AccommodationButton(initialText: trip.accommodation)),
              Divider(
                color: blue,
              ),
              Text(
                'Members: ${trip.friends.length}/${trip.members}',
                style: TextStyle(
                    fontSize: 32, color: blue, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: trip.friends.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      trip.friends[index],
                      style: TextStyle(
                          fontSize: 16,
                          color: blue,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: LeaveTripButton(
                  onPressed: () {
                    TripController()
                        .deleteATripFromDatabase(trip)
                        .then((value) {
                      Provider.of<TripProvider>(context, listen: false)
                          .removeTrip(trip);
                      Provider.of<TripProvider>(context, listen: false)
                          .loadTripsFromDatabase();
                      GoRouter.of(context).pushReplacement('/');
                    });
                    //context.pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveTripButton extends StatelessWidget {
  final Function onPressed;

  const LeaveTripButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 199, 85, 100),
        foregroundColor: Colors.white,
        elevation: 3,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        'Leave Trip',
        style: GoogleFonts.raleway(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
