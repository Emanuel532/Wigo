import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wigo/models/Trip.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/services/authentication_service.dart';
import 'package:wigo/services/authentication_utils.dart';

import 'package:wigo/widgets/buttons/generic_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isFirstBuild = true;

  @override
  void initState() {
    super.initState();
    // Load the trips from the database
    if (_isFirstBuild) {
      _isFirstBuild = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //_isFirstBuild = true;
    if (_isFirstBuild) {
      Provider.of<TripProvider>(context, listen: false).loadTripsFromDatabase();
      print('Loading trips from database');
    }

    Size screenSize = MediaQuery.of(context).size;
    print(Provider.of<TripProvider>(context).tripCount);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wigo Trip Planner'),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              //toDO: Add a list of trips here + design
              children: [
                Text(
                  'Welcome to Wigo Trip Planner  ${AuthenticationUtils.currentUser?.uid} !',
                  style: TextStyle(fontSize: 24),
                ),
                GenericButton(
                  text: 'Sign Out',
                  onPressed: () {
                    AuthenticationService.signOut();
                    // context.pop();
                  },
                ),
                Container(
                  height: (screenSize.height -
                          AppBar().preferredSize.height -
                          /*keyboardheight -*/
                          MediaQuery.of(context).viewPadding.top) *
                      0.78,
                  child: Consumer<TripProvider>(
                    builder: (context, tripProvider, child) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: ListTile(
                              title: Text('Trip no: $index'),
                              subtitle: Text(
                                  'City: ${tripProvider.trips[index].city}'),
                              trailing: Text(
                                  'Budget: ${tripProvider.trips[index].budget}'),
                            ),
                          );
                        },
                        itemCount: tripProvider.tripCount,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          GoRouter.of(context).go('/add-trip');
        },
      ),
    );
  }
}
