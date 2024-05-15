import 'package:flutter/foundation.dart';
import 'package:wigo/controllers/trip_controller.dart';
import 'package:wigo/models/Trip.dart';

class TripProvider with ChangeNotifier {
  List<Trip> trips = [];

  void loadTripsFromDatabase() async {
    // Load the trips from the database
    TripController tripController = TripController();
    trips = await tripController.getTripsFromDatabaseForConnectedUser();
    notifyListeners();
  }

  get getTripsList {
    return trips;
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
}
