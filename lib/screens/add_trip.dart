import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wigo/controllers/account_controller.dart';
import 'package:wigo/controllers/trip_controller.dart';
import 'package:wigo/models/Trip.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/services/authentication_utils.dart';

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
    photo: "",
  );

  @override
  Widget build(BuildContext context) {
    _trip.owner_uuid = AuthenticationUtils.currentUser?.uid != null
        ? AuthenticationUtils.currentUser!.uid
        : 'empty';
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Trip'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Start Date'),
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
                child: Text(_trip.startDate != null
                    ? _trip.startDate.toString()
                    : 'Select Start Date'),
              ),
              SizedBox(height: 16.0),
              Text('End Date'),
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
                child: Text(_trip.endDate != null
                    ? _trip.endDate.toString()
                    : 'Select End Date'),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(labelText: 'City'),
                onChanged: (value) {
                  setState(() {
                    _trip.city = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(labelText: 'Budget'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _trip.budget = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(labelText: 'Members'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _trip.members = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Friends'),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Add Friend'),
                        content: TextField(
                          onChanged: (value) {
                            setState(() {
                              _trip.friends.add(value);
                            });
                          },
                        ),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Add'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Add Friend'),
              ),
              SizedBox(height: 16.0),
              Text('Photo'),
              TextButton(
                onPressed: () {
                  //TODO: Implement photo selection logic here
                },
                child: Text('Add Photo'),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  //TODO: Implement trip creation logic here
                  Provider.of<TripProvider>(context, listen: false)
                      .addTrip(_trip);
                  context.pop();
                },
                child: Text('Create Trip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
