import 'dart:math';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wigo/controllers/account_controller.dart';
import 'package:wigo/controllers/trip_controller.dart';
import 'package:wigo/models/Trip.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/services/authentication_utils.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:wigo/widgets/budget_selector.dart';
import 'package:wigo/widgets/buttons/accommodation_button.dart';
import 'package:wigo/widgets/itinerary.dart';

final Color blue = Color.fromARGB(255, 85, 157, 199);
String tripAccommodation = 'Accommodation';

Future<Map<String, dynamic>> makeRequest(
    String location, int days, String inputBudget) async {
  print(inputBudget);
  var url = Uri.parse('https://api.llama-api.com/chat/completions');
  String budget = '';
  if (inputBudget == '\$')
    budget = 'low';
  else if (inputBudget == '\$\$')
    budget = 'medium';
  else if (inputBudget == '\$\$\$') budget = 'high';

  String txt = '';

  for (int i = 1; i <= days; i++) {
    txt +=
        '"day${i}": {"type": "string", "description": "Activities to do on Day ${i}, in the city specified. Activities need to be listed in separate lines. At least 4 activities"}';
    if (i != days) txt += ',';
  }

  String req = '';

  for (int i = 1; i <= days; i++) {
    req += '"day${i}"';
    if (i != days) req += ',';
  }

  var headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer LL-5iXRCkdyEYrO1j2YvaUmDpTugqtEUAKKtH9Dr4LguQaH2rnMvOSuLgFGBBVUXc4r', // Replace <token> with your actual token
  };
  var body = '''
  {
    "messages": [
        {"role": "user", "content": "Can you give me a ${days}-day trip plan for ${location}?"}
    ],
    "functions": [
        {
            "name": "get_itinerary",
            "description": "Get a day-by-day itinerary for a trip in a given city. Each day should have different activities. The itinerary should have each activity listed on a new line. Make sure all the letters are in the latin alphabet.",
            "parameters": {
                "type": "object",
                "properties": {
                  "accommodation" : {"type": "string", "description": "Provide an accommodation (a specific hostel, hotel etc.) option for the trip. Make sure it is a ${budget} budget accommodation."},
                  "city": {"type": "string", "description": "The city for the trip."},
                    $txt
                }
            },
                 "required": [$req ,"accommodation"]
           
        }
    ],
    "stream": false,
    "function_call": "get_itinerary"
  }
  ''';
  print('////////////////////////////////////////////////////////////////');
  print(headers);
  print('////////////////////////////////////////////////////////////////');
  print(body);
  var response = await http.post(url, headers: headers, body: body);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  final parsedResponse = json.decode(response.body);
  final arguments =
      parsedResponse['choices'][0]['message']['function_call']['arguments'];

  final tripAccommodation = arguments['accommodation'];
  final List<String> tripItinerary = [];

  arguments.forEach((key, value) {
    if (key.startsWith('day')) {
      // Check if the parameter starts with 'day'
      final activities =
          value.split(', ').join('\n'); // Join activities with new line
      tripItinerary.add(activities);
    }
  });

  final dictionary = {
    "itinerary": tripItinerary,
    "accommodation": tripAccommodation
  };

  print(dictionary);
  return dictionary;
}

int calculateNumberOfDays(DateTime startDate, DateTime endDate) {
  // Create new DateTime objects with the same date but with time set to 0
  DateTime start = DateTime(startDate.year, startDate.month, startDate.day);
  DateTime end = DateTime(endDate.year, endDate.month, endDate.day);

  // Calculate the difference in milliseconds between the two dates
  int differenceInMilliseconds = end.difference(start).inMilliseconds;

  // Convert milliseconds to days (1 day = 24 hours * 60 minutes * 60 seconds * 1000 milliseconds)
  int differenceInDays =
      (differenceInMilliseconds / (24 * 60 * 60 * 1000)).round();
  print(start);
  print(end);
  print(differenceInDays + 1);
  return differenceInDays + 1;
}

String formatDateTime(DateTime dateTime) {
  // Define the format pattern
  final DateFormat formatter = DateFormat('dd MMM yyyy');

  // Format the DateTime object
  return formatter.format(dateTime).toUpperCase();
}

class AddTripScreen extends StatefulWidget {
  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  Trip _trip = Trip(
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    owner_uuid: 'empty',
    city: "",
    isPublic: false,
    budget: '\$',
    members: 1,
    accommodation: 'Accommodation',
    friends: [AuthenticationUtils.currentUser?.email ?? 'empty'],
    itinerary: ['The itinerary will be here.'],
    photo: "",
  );

  bool isTripPublic = false;
  String _selectedBudget = '\$';

  void _handleBudgetSelected(String budget) {
    setState(() {
      _selectedBudget = budget;
    });
  }

  @override
  Widget build(BuildContext context) {
    _trip.owner_uuid = AuthenticationUtils.currentUser?.uid != null
        ? AuthenticationUtils.currentUser!.uid
        : 'empty';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create your trip',
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 85, 157, 199).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _trip.city = value;
                    });
                  },
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 85, 157, 199),
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Location',
                    hintStyle: GoogleFonts.raleway(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 85, 157, 199),
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
                    ),
                    icon: Icon(Icons.location_on,
                        color: Color.fromARGB(255, 85, 157, 199), size: 30),
                  ),
                ),
              ),
              SizedBox(
                height: 64,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'First Day',
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                            color: blue,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  _trip.startDate = date;
                                });
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                _trip.startDate != null
                                    ? formatDateTime(_trip.startDate)
                                    : 'Select Start Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: blue,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: blue,
                      thickness: 1,
                    ),
                    Column(
                      children: [
                        Text(
                          'Last Day',
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                            color: blue,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  _trip.endDate = date;
                                });
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                _trip.startDate != null
                                    ? formatDateTime(_trip.endDate)
                                    : 'Select Start Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: blue,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 64.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BudgetSelector(onBudgetSelected: _handleBudgetSelected),

                  SizedBox(width: 10), // Add some space between the text fields
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      decoration: InputDecoration(
                        label: Center(
                          child: Icon(
                            Icons.people_alt,
                            color: blue,
                            size: 40,
                          ),
                        ),
                        labelStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 85, 157, 199),
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: blue, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 32.0, color: blue),
                      onChanged: (value) {
                        setState(() {
                          _trip.members = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64.0),
              Row(children: [
                Text(
                  "Make trip public",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: blue,
                  ),
                ),
                Spacer(),
                Checkbox(
                    value: isTripPublic,
                    onChanged: (valoare) {
                      setState(() {
                        isTripPublic = valoare ?? false;
                      });
                    }),
              ]),
              SizedBox(height: 64.0),
              TextButton(
                onPressed: () {
                  makeRequest(
                          _trip.city,
                          calculateNumberOfDays(_trip.startDate, _trip.endDate),
                          _selectedBudget)
                      .then((dictionary) {
                    // Handle trip itinerary here
                    _trip.itinerary = dictionary['itinerary'];
                    _trip.accommodation = dictionary['accommodation'];
                    setState(() {});
                  }).catchError((error) {
                    // Handle errors
                    print('Error: $error');
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 85, 157, 199),
                  foregroundColor: Colors.white,
                  elevation: 3,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Plan trip with AI',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              ItineraryBox(
                itineraryItems: _trip.itinerary,
              ),
              SizedBox(
                height: 16,
              ),
              AccommodationButton(initialText: _trip.accommodation),
              SizedBox(height: 64.0),
              TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 85, 157, 199),
                  foregroundColor: Colors.white,
                  elevation: 3,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  //TODO: Implement trip creation logic here
                  Random random = Random();
                  _trip.inviteCode = random.nextInt(9000) + 1000;
                  _trip.budget = _selectedBudget;
                  _trip.isPublic = isTripPublic;
                  Provider.of<TripProvider>(context, listen: false)
                      .addTrip(_trip);
                  context.pop();
                },
                child: Text(
                  'Create',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
