import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputBubble extends StatelessWidget {
  final String hintText;
  static const Map<String, IconData> hintIcons = {
    'Email': Icons.email,
    'Username': Icons.person,
    'Password': Icons.lock,
  };
   const InputBubble({Key? key, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final IconData icon = hintIcons.containsKey(hintText)
        ? hintIcons[hintText]!
        : Icons.person; // Default icon


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child:  TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.raleway(
            textStyle: TextStyle(color: Color.fromARGB(255, 85, 157, 199), fontSize: 24),
          ),
          icon: Icon(icon, color: Color.fromARGB(255, 85, 157, 199), size: 30,),
        ),
      ),
    );;
  }
}