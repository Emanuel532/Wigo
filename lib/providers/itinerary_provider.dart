import 'package:flutter/foundation.dart';
import 'package:wigo/models/Itinerary.dart';

class ItineraryProvider with ChangeNotifier {
  Itinerary _itinerary = Itinerary(totalDays: 0, dailyBlocks: []);

  Itinerary get getItinerary => _itinerary;

  void setDailyActivity(String dailyActivity, int day) {
    _itinerary.dailyBlocks[0] = dailyActivity;
    notifyListeners();
  }

  void setTotalDays(int totalDays) {
    _itinerary.totalDays = totalDays;
    _itinerary.dailyBlocks = List.generate(totalDays, (index) => '');
    notifyListeners();
  }
}
