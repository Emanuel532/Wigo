import 'package:wigo/models/Trip.dart';
import 'package:wigo/services/cloud_firebase_service.dart';

class AddTripController {
  final CloudFirebaseService _firebaseService = CloudFirebaseService();

  AddTripController();

  void addNewTrip(Trip trip) {
    // Save the new trip using the CloudFirebaseService
    //_firebaseService.saveTrip(trip);
    _firebaseService.addDocument('trips', trip.toJSON());
  }
}
