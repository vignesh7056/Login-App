import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HomePage.dart';

class User {
  final String username;
  final String password;

  User({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class SignInButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Function(bool) onSignInSuccess;

  const SignInButton({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.onSignInSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final username = usernameController.text;
        final password = passwordController.text;
        final user = User(username: username, password: password);

        // Call the backend API to authenticate the user
        final bool isAuthenticated = await authenticateUser(user);

        if (isAuthenticated) {
          // Navigate to the homepage component if authentication is successful
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          // Handle authentication failure (show an error message, etc.)
          // You can use a SnackBar or showDialog to display an error message.
        }
      },
      child: Text('Sign In'),
    );
  }

  Future<bool> authenticateUser(User user) async {
    final String apiUrl =
        'https://example.com/authenticate'; // Replace with your actual authentication endpoint URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(user.toJson()), // Serialize user object to JSON
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final bool isAuthenticated = responseData['authenticated'];

        return isAuthenticated;
      } else {
        // Handle errors, e.g., server errors or invalid credentials
        return false;
      }
    } catch (e) {
      // Handle network errors or other exceptions
      return false;
    }
  }
}
