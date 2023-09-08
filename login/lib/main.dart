import 'package:flutter/material.dart';
import 'package:login/components/SignInButton.dart';
import 'package:login/components/SignUpButton.dart';
import 'components/my_textfield.dart';
import 'components/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 195, 194, 194),
        body: SafeArea(
          child: Center(
            child: Builder(
              builder: (BuildContext builderContext) {
                return Column(
                  children: [
                    SizedBox(height: 50),
                    Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 82, 73, 76),
                      size: 100,
                    ),
                    SizedBox(height: 50),
                    Text('Welcome Back'),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 100,
                      width: 250,
                      child: MyTextField(
                        controller: usernameController,
                        hintText: 'Username',
                        obscureText: false,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 250,
                      child: MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle forgot password here
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 82, 73, 76),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SignInButton(
                      usernameController: usernameController,
                      passwordController: passwordController,
                      onSignInSuccess: (bool isAuthenticated) {
                        if (isAuthenticated) {
                          // Navigate to the home page component on success
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else {
                          // Display a Snackbar with a login error message on failure
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Login failed. Please check your credentials.',
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                    ),
                    SignUpButton(context: context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
