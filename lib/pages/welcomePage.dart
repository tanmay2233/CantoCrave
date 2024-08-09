import 'package:canto_crave/cart_list_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Theme/themes.dart';
import '../routes/routes.dart';
import '../services/auth_service.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late PageController _pageController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, MyRoutes.bottomBar);
      }
    } catch (error) {
      print("Error during Google sign-in: $error");
    }
  }

  void _goToNextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String _upperText = '';
    String _lowerText = '';

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyTheme.canvasDarkColor, MyTheme.canvasLightColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topCenter)),
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == 0) {
                _upperText = "Welcome to CantoCrave";
                _lowerText =
                    "Beat The Crowd & Order Your Favourite Snacks From Your Room";
              } else if (index == 1) {
                _upperText = "Collect Your Food From Canteen";
                _lowerText = "Let's SignIn Now..";
              }
              return (index < 2)
                  ? Column(
                      children: [
                        SizedBox(height: size.height * 0.02),
                        Text(_upperText,
                            style: TextStyle(
                                color: MyTheme.cardColor,
                                fontSize: size.width * 0.06),
                            textAlign: TextAlign.center),
                        Image.asset("images/${index + 1}.png"),
                        SizedBox(height: size.height * 0.03),
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.04),
                          child: Text(_lowerText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.04),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: size.height * 0.02),
                        InkWell(
                          onTap: () {
                            _goToNextPage();
                          },
                          child: Icon(CupertinoIcons.right_chevron,
                              color: MyTheme.cardColor, size: size.width * 0.1),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'images/logo.png',
                          height: size.height * 0.25,
                        ),
                        SizedBox(
                            height: 40,
                            child: SignInButton(
                              Buttons.google,
                              onPressed: _handleGoogleSignIn,
                              text: "Sign in with Google",
                            ))
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
