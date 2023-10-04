// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Theme/themes.dart';
import '../routes/routes.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _NameTextController =
      TextEditingController(text: "");
  final TextEditingController _MobileNumberTextController =
      TextEditingController(text: "");

  void addUserDetailsToFirebase(String name, String mobile) async {
    final userDetailRef = FirebaseFirestore.instance
        .collection('userDetail')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    final userDetails = {
      'name': name,
      'mobile': mobile,
    };
    await userDetailRef.set(userDetails);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
                begin: Alignment.topCenter)),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02),
                      child: "Hi,  ${user?.displayName} !"
                          .text
                          .xl4
                          .color(Colors.white)
                          .make(),
                    ),
                    _MyListTile(
                        context: context,
                        title: "Profile",
                        icon: CupertinoIcons.profile_circled,
                        onPressed: () async {
                          await AddressUpdateDialog();
                        }),
                    _MyListTile(
                        context: context,
                        title: "My Orders",
                        icon: Icons.assignment_rounded,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.myOrdersPageRoute);
                        }),
                    _MyListTile(
                        context: context,
                        title: "Logout",
                        icon: Icons.logout_sharp,
                        onPressed: () async {
                          await LogoutDialog();
                        })
                  ],
                ),
                Image.asset(
                  "images/logo.png",
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _MyListTile(
      {required BuildContext context,
      required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.022),
      child: ListTile(
        leading: Icon(
          icon,
          color: MyTheme.iconColor,
          size: MediaQuery.of(context).size.width * 0.0675,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: MyTheme.fontColor,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          subtitle ?? "",
          style: TextStyle(
              color: Color.fromARGB(255, 204, 196, 185),
              fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right_outlined,
          size: MediaQuery.of(context).size.width * 0.08,
          color: Colors.white70,
        ),
        onTap: () {
          onPressed();
        },
      ),
    );
  }

  Future<void> AddressUpdateDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
            backgroundColor: MyTheme.canvasDarkColor,
            title: Text(
              "Update/Add Personal Info",
              style: TextStyle(color: MyTheme.cardColor),
            ),
            content: SizedBox(
              height: size.height * 0.22,
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.fontColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.fontColor)),
                        hintText: "Enter Name",
                        hintStyle: TextStyle(color: Vx.white)),
                    controller: _NameTextController,
                    maxLines: 1,
                  ),
                  SizedBox(height: size.height * 0.055),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.fontColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.fontColor)),
                        hintText: "Enter Mobile Number",
                        hintStyle: TextStyle(color: Vx.white)),
                    controller: _MobileNumberTextController,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_NameTextController.text != '' &&
                        (_MobileNumberTextController.text.length == 10 &&
                            (_MobileNumberTextController.text[0] == '9' ||
                                _MobileNumberTextController.text[0] == '8' ||
                                _MobileNumberTextController.text[0] == '7' ||
                                _MobileNumberTextController.text[0] == '6'))) {
                      Navigator.pop(context);
                      addUserDetailsToFirebase(_NameTextController.text,
                          _MobileNumberTextController.text);
                    } else {
                      final snackBar = SnackBar(
                        content: Text('Recheck Details'),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(label: '', onPressed: () {}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: MyTheme.fontColor),
                  ))
            ],
          );
        });
  }

  Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> LogoutDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: MyTheme.canvasDarkColor,
            title: Text(
              "Logout",
              style: TextStyle(color: MyTheme.fontColor),
            ),
            content: Text(
              "Are you sure you want to logout?",
              style: TextStyle(color: Vx.white),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    await signOut();
                    Navigator.pop(context);
                    Navigator.pushNamed(context, MyRoutes.welcomePageRoute);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: MyTheme.fontColor, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.17,
              ),
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text("No",
                    style: TextStyle(
                      color: MyTheme.fontColor,
                      fontWeight: FontWeight.bold))),
            ],
          );
        });
  }
}
