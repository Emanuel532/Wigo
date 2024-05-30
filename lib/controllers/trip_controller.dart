import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_client/unsplash_client.dart';
import 'package:wigo/models/Trip.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/services/cloud_firebase_service.dart';

class TripController {
  final CloudFirebaseService _firebaseService = CloudFirebaseService();

  TripController();

  void addNewTripToDatabase(Trip trip) async {
    // Save the new trip using the CloudFirebaseService
    //_firebaseService.saveTrip(trip);
    final client = UnsplashClient(
      settings: ClientSettings(
          credentials: AppCredentials(
        accessKey: 'h88Aszflj24Eqpr8XbbyO26YARfwjdRM_M7ddp2ZxLU',
        secretKey: 'AXcSDDax9bOuz_P08NF2c9ZDchVAKHH9ZDlLbYA8fqA',
      )),
    );
    var photos =
        await client.photos.random(query: trip.city, count: 1).goAndGet();

    trip.photo = photos[0].urls.regular.toString();
    _firebaseService.addDocument('trips', trip.toJSON());
    client.close();
  }

  Future<Trip> getTripByInviteCode(int inviteCode, String email) {
    Trip toBeReturnedTrip = Trip(
        city: 'No city',
        photo: "",
        itinerary: [],
        members: 0,
        budget: '',
        owner_uuid: 'No owner',
        friends: [],
        isPublic: false,
        accommodation: 'Accommodation',
        startDate: DateTime.now(),
        endDate: DateTime.now());
    // Load the trips from the database
    return _firebaseService
        .getTripByInviteCode(inviteCode, email)
        .then((tripData) {
      Trip trip = Trip.fromJSON(tripData.data() ?? {});
      //print(trip.city);
      toBeReturnedTrip = trip;
      return trip;
    });
  }

  Future getTripsFromDatabaseForConnectedUser() async {
    String uuid = FirebaseAuth.instance.currentUser?.uid != null
        ? FirebaseAuth.instance.currentUser!.uid
        : '';
    // Load the trips from the database
    /*return _firebaseService.getTripsByOwnerAndFriends(uuid).then((tripsData) {
      List<Trip> trips = [];
      tripsData.docs.forEach((tripData) {
        Trip trip = Trip.fromJSON(tripData.data());
        trips.add(trip);
      });
      return trips;
    });
    */
    List<Trip> trips = [];
    await _firebaseService.getTripsByOwnerAndFriends(uuid).then((tripsData) {
      List<Trip> trips = [];
      tripsData.docs.forEach((tripData) {
        Trip trip = Trip.fromJSON(tripData.data());
        trips.add(trip);
      });
    });

    await _firebaseService
        .getTripsByMembership(FirebaseAuth.instance.currentUser?.email ?? '')
        .then((tripsData) {
      tripsData.docs.forEach((tripData) {
        Trip trip = Trip.fromJSON(tripData.data());
        trips.add(trip);
      });
    });

    return trips;
  }

  Future getPublicTrips() async {
    List<Trip> trips = [];
    await _firebaseService.getPublicTrips().then((tripsData) {
      tripsData.docs.forEach((tripData) {
        Trip trip = Trip.fromJSON(tripData.data());
        trips.add(trip);
      });
      print(trips.length);
    });

    return trips;
  }
/*
  Future joinTrip(int inviteCode) async {
    String uuid = FirebaseAuth.instance.currentUser?.uid != null
        ? FirebaseAuth.instance.currentUser!.uid
        : '';
    // Load the trips from the database
    return _firebaseService.getTripByInviteCode(inviteCode).then((tripData) {
      Trip trip = Trip.fromJSON(tripData.data());
      trip.friends.add(uuid);
      _firebaseService.updateTrip(trip);
      return trip;
    });
  }*/

  Future<bool> deleteATripFromDatabase(Trip trip) async {
    _firebaseService.deleteTrip(trip).then((value) {
      print('s a facut');
      return true;
    });
    return false;
  }
}
