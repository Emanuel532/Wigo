import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GenericButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
