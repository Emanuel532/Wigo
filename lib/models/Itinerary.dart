class Itinerary {
  int totalDays;
  List<String> dailyBlocks = [''];
  Itinerary({required this.totalDays, required this.dailyBlocks});

  void updateDailyBlock(int day, String newBlock) {
    if (day >= 1 && day <= totalDays) {
      dailyBlocks[day - 1] = newBlock;
    } else {
      throw Exception('Invalid day');
    }
  }

  void setDailyActivity(String dailyActivity, int dayIndex) {
    dailyBlocks[dayIndex] = dailyActivity;
  }

  void setTotalDays(int totalDays) {
    totalDays = totalDays;
    dailyBlocks = List.generate(totalDays, (index) => '');
  }

  Itinerary empty() {
    return Itinerary(totalDays: 0, dailyBlocks: []);
  }

  factory Itinerary.fromJSON(Map<String, dynamic> json) {
    return Itinerary(
      totalDays: json['totalDays'],
      dailyBlocks: List<String>.from(json['dailyBlocks']),
    );
  }
}
