import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wigo/models/Trip.dart';
import 'package:wigo/providers/trip_provider.dart';
import 'package:wigo/services/authentication_service.dart';
import 'package:wigo/services/authentication_utils.dart';

import 'package:wigo/widgets/buttons/generic_button.dart';
import 'package:wigo/widgets/trip_card.dart';

Color blue = Color.fromARGB(255, 85, 157, 199);

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
    // _isFirstBuild = true;
    if (_isFirstBuild) {
      Provider.of<TripProvider>(context, listen: false).loadTripsFromDatabase();
      print('Loading trips from database');
    }

    Size screenSize = MediaQuery.of(context).size;
    print(Provider.of<TripProvider>(context).tripCount);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: false,
        title: Text(
          'WIGO',
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.w800, fontSize: 60, color: Colors.white),
        ),
        toolbarHeight: 90,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<TripProvider>(context, listen: false)
              .loadTripsFromDatabase();
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text(
                'Welcome!',
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w800, fontSize: 50, color: blue),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                'Connected with: ${AuthenticationUtils.currentUser?.email}',
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w500, fontSize: 32, color: blue),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 85, 157, 199),
                foregroundColor: Colors.white,
                elevation: 3,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Sign Out',
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w400,
                    fontSize: 26,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onPressed: () {
                AuthenticationService.signOut();
                GoRouter.of(context).pushReplacement('/login');
              },
            ),
            Divider(
              color: blue,
              thickness: 2,
            ),
            Center(
              child: Column(
                //toDO: Add a list of trips here + design
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      'Your trips',
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w800,
                          fontSize: 42,
                          color: blue),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: (screenSize.height -
                            AppBar().preferredSize.height -
                            /*keyboardheight -*/
                            MediaQuery.of(context).viewPadding.top) *
                        0.46,
                    child: Consumer<TripProvider>(
                      builder: (context, tripProvider, child) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  GoRouter.of(context)
                                      .go('/view-trip/${index.toString()}');
                                },
                                child: TripCard(
                                  endDate: tripProvider.trips[index].endDate,
                                  startDate:
                                      tripProvider.trips[index].startDate,
                                  location: tripProvider.trips[index].city,
                                  maxMembers: tripProvider.trips[index].members,
                                  numberOfMembers:
                                      tripProvider.trips[index].friends.length,
                                ));
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
