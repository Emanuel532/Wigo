import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccommodationButton extends StatefulWidget {
  final String initialText;

  const AccommodationButton({required this.initialText});

  @override
  State<AccommodationButton> createState() => _AccommodationButtonState();
}

class _AccommodationButtonState extends State<AccommodationButton> {
  String _text = '';

  @override
  void initState() {
    super.initState();
    _text = widget.initialText; // Use initial text
  }

  void _updateText() {
    setState(() {
      _text = 'Updated Text'; // Change the text here
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _updateText, // Call update function on press
      child: Text(
        _text, // Use current text state
        style: GoogleFonts.raleway(
          fontWeight: FontWeight.w600,
          fontSize: 32,
          color: Colors.blue,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 3,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.blue, width: 1.0),
        ),
      ),
    );
  }
}
