import 'package:flutter/foundation.dart';
import 'package:wigo/controllers/trip_controller.dart';
import 'package:wigo/models/Trip.dart';

class TripProvider with ChangeNotifier {
  List<Trip> trips = [];
  List<Trip> publicTrips = [];

  void loadTripsFromDatabase() async {
    // Load the trips from the database
    TripController tripController = TripController();
    tripController.getTripsFromDatabaseForConnectedUser().then((value) {
      trips = value as List<Trip>;

      notifyListeners();
    });

    tripController.getPublicTrips().then((value) {
      print('dataa');
      print(value);
      publicTrips = value as List<Trip>;
      print("DEBUGGG");
      print(publicTrips.length);
      notifyListeners();
    });
  }

  get getTripsList {
    return trips;
  }

  Trip getTripById(int tripId) {
    return trips[tripId];
  }

  Trip getPublicTripById(int tripId) {
    return publicTrips[tripId];
  }

  void addTrip(Trip _trip) {
    TripController addTripController = TripController();
    addTripController.addNewTripToDatabase(_trip);
    trips.add(_trip); //add to the local provider list
    notifyListeners();
  }

  void removeTrip(Trip _trip) {
    trips.remove(_trip);
    notifyListeners();
  }

  int get tripCount {
    return trips.length;
  }

  int get publicTripCount {
    return publicTrips.length;
  }
/*
  void joinTrip(int inviteCode) {
    TripController tripController = TripController();
    tripController.joinTrip(inviteCode);
    Trip tripp = tripController.getTripByInviteCode(inviteCode);
    trips.add(tripp);
    notifyListeners();
  }
  */
}
