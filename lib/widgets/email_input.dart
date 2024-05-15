import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController emailController;

  const EmailInput({Key? key, required this.emailController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: TextField(
        controller: emailController, // Assign the provided emailController
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
            color: Color.fromARGB(255, 85, 157, 199),
            fontSize: 24,
          ),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Email',
          hintStyle: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 85, 157, 199),
              fontSize: 24,
            ),
          ),
          icon: Icon(Icons.email, color: Color.fromARGB(255, 85, 157, 199), size: 30),
        ),
      ),
    );
  }
}
