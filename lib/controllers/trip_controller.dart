import 'package:firebase_auth/firebase_auth.dart';
import 'package:wigo/models/Trip.dart';
import 'package:wigo/services/cloud_firebase_service.dart';

class TripController {
  final CloudFirebaseService _firebaseService = CloudFirebaseService();

  TripController();

  void addNewTripToDatabase(Trip trip) {
    // Save the new trip using the CloudFirebaseService
    //_firebaseService.saveTrip(trip);
    _firebaseService.addDocument('trips', trip.toJSON());
  }

  Future getTripsFromDatabaseForConnectedUser() {
    String uuid = FirebaseAuth.instance.currentUser?.uid != null
        ? FirebaseAuth.instance.currentUser!.uid
        : '';
    // Load the trips from the database
    return _firebaseService.getTripsByOwnerAndFriends(uuid).then((tripsData) {
      List<Trip> trips = [];
      tripsData.docs.forEach((tripData) {
        Trip trip = Trip.fromJSON(tripData.data());
        trips.add(trip);
      });
      return trips;
    });
  }
}
