import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Color.fromARGB(255, 82, 73, 76), // Set the background color
        elevation: 4, // Set the elevation (shadow)
        centerTitle: true, // Center-align the title
        automaticallyImplyLeading: false, // Remove the back button
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Color.fromARGB(255, 195, 194, 194), // Set the text color
          ),
        ),
      ),

      backgroundColor: Color.fromARGB(255, 195, 194, 194), // Background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle registration logic
                  registerUser(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 82, 73, 76), // Button color
                ),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 82, 73, 76), // Set the desired button color
                ),
                onPressed: () {
                  // Navigate back to the login page
                  Navigator.of(context).pop();
                },
                child: Text('Back to Login',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser(BuildContext context) async {
    final username = usernameController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      // Passwords don't match, show an error message
      _showSnackBar(context, 'Passwords do not match.');
      return;
    }

    final user = User(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    // Call the backend API to register the user
    final bool isRegistered = await registerUserApi(user);

    if (isRegistered) {
      // Registration successful, show a success message
      _showSnackBar(context, 'Registration successful.');

      // Navigate to the login page
      Navigator.of(context).pop();
    } else {
      // Registration failed, show an error message
      _showSnackBar(context, 'Registration failed. Please try again.');
    }
  }

  Future<bool> registerUserApi(User user) async {
    final String apiUrl =
        'https://example.com/register'; // Replace with your actual registration endpoint URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(user.toJson()), // Serialize user object to JSON
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final bool isRegistered = responseData['registered'];

        return isRegistered;
      } else {
        // Handle errors, e.g., server errors or invalid data
        return false;
      }
    } catch (e) {
      // Handle network errors or other exceptions
      return false;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
