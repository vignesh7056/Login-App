import 'package:flutter/material.dart';
import 'package:login/components/SignUpForm.dart';

class SignUpButton extends StatelessWidget {
  final BuildContext context;

  SignUpButton({
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the SignUpForm component when the button is pressed
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SignUpForm(),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(255, 86, 84, 85),
        ),
      ),
      child: Text('Sign Up'),
    );
  }
}
