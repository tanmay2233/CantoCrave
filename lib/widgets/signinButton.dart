import 'package:flutter/material.dart';

import '../Theme/themes.dart';
import '../routes/routes.dart';
import '../services/auth_service.dart';

class SignInButton extends StatefulWidget {
  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool _isLoading = false;

  void signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await AuthService().signInWithGoogle();

      if (user != null) {
        Navigator.pushNamed(context, MyRoutes.bottomBar);
      } else {
        print(123);
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator(color: MyTheme.cardColor,)
        : ElevatedButton(
            onPressed: signInWithGoogle,
            child: Text('Sign In with Google'),
          );
  }
}
