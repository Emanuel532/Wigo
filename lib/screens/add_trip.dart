import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wigo/controllers/account_controller.dart';
import 'package:wigo/controllers/trip_controller.dart';
import 'package:wigo/models/Trip.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/services/authentication_utils.dart';
import 'package:intl/intl.dart';
import 'package:wigo/widgets/itinerary.dart';

final Color blue = Color.fromARGB(255, 85, 157, 199);

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
    budget: 0,
    members: 1,
    friends: [],
    itinerary: [],
    photo: "",
  );

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
            fontWeight: FontWeight.w400,
            fontSize: 30,
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
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Budget',
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
                          _trip.budget = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                  ),

                  SizedBox(width: 10), // Add some space between the text fields
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Members',
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
              ItineraryBox(days: 3),
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
