import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'email_signup.dart';

class EmailSignInDialog extends StatefulWidget {
  @override
  _EmailSignInDialogState createState() => _EmailSignInDialogState();
}

class _EmailSignInDialogState extends State<EmailSignInDialog> {
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // On successful sign-in
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed in as ${userCredential.user?.email}')),
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
      title: Text("Sign in"),
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
            return EmailSignUpDialog();
          },
        );
        },
      child: Text("Register Here"),
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
          child: Text("Sign In"),
        ),
      ],
    );
  }
}
