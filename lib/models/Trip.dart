class Trip {
  DateTime startDate;
  DateTime endDate;
  String city;
  String owner_uuid;
  double budget;
  int members;
  List<String> friends;
  String photo;

  Trip({
    required this.startDate,
    required this.endDate,
    required this.owner_uuid,
    required this.city,
    required this.budget,
    required this.members,
    required this.friends,
    required this.photo,
  });

  Map<String, dynamic> toJSON() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'owner_uuid': owner_uuid,
      'city': city,
      'budget': budget,
      'members': members,
      'friends': friends,
      'photo': photo,
    };
  }

  factory Trip.fromJSON(Map<String, dynamic> json) {
    return Trip(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      owner_uuid: json['owner_uuid'],
      city: json['city'],
      budget: json['budget'].toDouble(),
      members: json['members'],
      friends: List<String>.from(json['friends']),
      photo: json['photo'],
    );
  }
}
