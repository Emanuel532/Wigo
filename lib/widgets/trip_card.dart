import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  // Define the format pattern
  final DateFormat formatter = DateFormat('dd MMM yyyy');

  // Format the DateTime object
  return formatter.format(dateTime).toUpperCase();
}

class TripCard extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final int numberOfMembers;
  final int maxMembers;

  const TripCard({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.numberOfMembers,
    required this.maxMembers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 85, 157, 199),
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  location,
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Text(
                  '$numberOfMembers/$maxMembers',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
              color: Colors.white,
            ),
            SizedBox(height: 5),
            Text(
              '${formatDateTime(startDate)} - ${formatDateTime(endDate)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
