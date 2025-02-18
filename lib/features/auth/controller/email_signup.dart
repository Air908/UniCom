import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'email_signin.dart';

class EmailSignUpDialog extends StatefulWidget {
  @override
  _EmailSignUpDialogState createState() => _EmailSignUpDialogState();
}

class _EmailSignUpDialogState extends State<EmailSignUpDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // A function to handle sign-in or sign-up
  Future<void> _signInOrSignUp() async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in both fields')),
        );
        return;
      }

      // Check if user is already signed in or register if new user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // On successful sign-in
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registered as ${userCredential.user?.email}')),
      );

      // Close the dialog
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else {
        message = 'An error occurred. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sign Up"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EmailSignInDialog();
              }
            );
          },
          child: Text("Sign In"),
        ),
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: _signInOrSignUp,
          child: Text("Register"),
        ),
      ],
    );
  }
}
