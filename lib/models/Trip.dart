class Trip {
  DateTime startDate;
  DateTime endDate;
  String city;
  String owner_uuid;
  String budget;
  late int inviteCode;
  int members;
  List<String> friends;
  List<String> itinerary;
  bool isPublic = false;
  String photo;
  String id = "";
  String accommodation = 'Accommodation';

  Trip({
    required this.startDate,
    required this.endDate,
    required this.owner_uuid,
    required this.city,
    required this.budget,
    required this.members,
    required this.friends,
    this.inviteCode = 0,
    required this.itinerary,
    required this.photo,
    required this.accommodation,
    required this.isPublic,
  });

  Map<String, dynamic> toJSON() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'owner_uuid': owner_uuid,
      'city': city,
      'inviteCode': inviteCode,
      'budget': budget,
      'members': members,
      'friends': friends,
      'itinerary': itinerary,
      'photo': photo,
      'accommodation': accommodation,
      'isPublic': isPublic,
    };
  }

  factory Trip.fromJSON(Map<String, dynamic> json) {
    return Trip(
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        owner_uuid: json['owner_uuid'],
        city: json['city'],
        budget: json['budget'],
        members: json['members'],
        friends: List<String>.from(json['friends']),
        itinerary: List<String>.from(json['itinerary']),
        inviteCode: json['inviteCode'],
        photo: json['photo'],
        isPublic: json['isPublic'],
        accommodation: json['accommodation']);
  }

  //function to return an empty trip
  static Trip empty() {
    return Trip(
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        owner_uuid: '',
        city: '',
        budget: '',
        members: 0,
        friends: [],
        itinerary: [],
        isPublic: false,
        photo: '',
        accommodation: 'Accommodation');
  }
}
