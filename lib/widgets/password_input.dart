import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordInput({Key? key, required this.passwordController}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.passwordController, // Assign the provided passwordController
              obscureText: _obscureText,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 85, 157, 199),
                  fontSize: 24,
                ),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Password',
                hintStyle: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 85, 157, 199),
                    fontSize: 24,
                  ),
                ),
                icon: Icon(Icons.lock, color: Color.fromARGB(255, 85, 157, 199), size: 30),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Color.fromARGB(255, 85, 157, 199),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ],
      ),
    );
  }
}
