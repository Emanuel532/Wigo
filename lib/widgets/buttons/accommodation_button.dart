import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void promptGoogleSearch(String query) async {
  final String urlString =
      'https://www.google.com/search?q=${Uri.encodeComponent(query)}';
  final Uri url = Uri.parse(urlString);

  if (await canLaunch(urlString)) {
    await launch(urlString);
  } else {
    throw Exception('Could not launch $urlString');
  }
}

class AccommodationButton extends StatelessWidget {
  final String initialText;

  const AccommodationButton({
    Key? key,
    required this.initialText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        promptGoogleSearch(initialText);
      }, // Call update function on press
      child: Text(
        initialText, // Use current text state
        style: GoogleFonts.raleway(
          fontWeight: FontWeight.w600,
          fontSize: 32,
          color: Color.fromARGB(255, 85, 157, 199),
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 85, 157, 199),
        elevation: 3,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side:
              BorderSide(color: Color.fromARGB(255, 85, 157, 199), width: 1.0),
        ),
      ),
    );
  }
}
