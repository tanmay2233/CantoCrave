// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/routes/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Theme/themes.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _AddressTextController = TextEditingController(text: "");

  @override
  void dispose(){
    _AddressTextController.dispose();
    super.dispose();
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
      
          child: 
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                            
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                            Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.02),
                              child: "Hi,  ${user?.displayName} !".text.xl4.color(Colors.white).make(),
                            ),
                        
                            _MyListTile(
                              context: context,
                                title: "Address",
                                subtitle: "My Address",
                                icon: Icons.home,
                                onPressed: () async {
                                  await AddressUpdateDialog();
                                }),
                            
                              _MyListTile(context: context, title: "My Orders", 
                              icon: Icons.assignment_rounded, onPressed: (){}),
                            
                            _MyListTile(
                                context: context,
                                title: "Wishlist",
                                icon: CupertinoIcons.heart_fill,
                                onPressed: () {}),
                            
                            _MyListTile(
                                context: context,
                                title: "Viewed",
                                icon: CupertinoIcons.eye_fill,
                                onPressed: () {}),
                            
                            _MyListTile(
                                context: context,
                                title: "Logout",
                                icon: Icons.logout_sharp,
                                onPressed: () async {
                                  await LogoutDialog();
                                }
                                )
                        ],
                      ),
                      Image.asset("images/logo.png",
                      width: MediaQuery.of(context).size.width*0.3,
                      height: MediaQuery.of(context).size.height*0.3,
                    )
                  ]
                ),
                          ),
                        ),
              ),
      ),
    );
  }

  Widget _MyListTile(
      {
      required BuildContext context,
      required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width*0.022
      ),
      child: ListTile(
        leading: Icon(icon, color: MyTheme.iconColor, size: MediaQuery.of(context).size.width * 0.0675,),
        title: Text(title, 
        style: TextStyle(
          color: MyTheme.fontColor,
          fontSize: 20,
        ),
        ),
        subtitle: Text(subtitle ?? "",
        style: TextStyle(
              color: Color.fromARGB(255, 204, 196, 185),
              fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.keyboard_arrow_right_outlined,
        size: MediaQuery.of(context).size.width*0.08,
        color: Colors.white70,
        ),
        onTap: () {
          onPressed();
        },
      ),
    );
  }

  Future<void> AddressUpdateDialog() async{
    showDialog(context: context, builder: (context){
        return AlertDialog(
        
          backgroundColor: MyTheme.canvasDarkColor,
          title: Text("Update Address", 
          style: TextStyle(color: MyTheme.fontColor),
          ),

          content: Theme(
            data: MyLoginPageTheme.loginPageTheme(context),
            child: TextField(
              style: TextStyle(color: MyTheme.fontColor),

              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyTheme.fontColor)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyTheme.fontColor)
                ),
                hintText: "Enter new Address",
                hintStyle: TextStyle(
                  color: Vx.white
                )
              ),

              controller: _AddressTextController,

              maxLines: 4,
            ),
          ),
          actions: [
            TextButton(onPressed: (){},
            child: Text("Update", style: TextStyle(color: MyTheme.fontColor),))
          ],
        );
      }
    );


  }

  Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

    Future<void> LogoutDialog() async {
      return showDialog(context: context, 
        builder: (context){
          return AlertDialog(
            backgroundColor: MyTheme.canvasDarkColor,

            title: Text("Logout",
              style: TextStyle(color: MyTheme.fontColor),
            ),

            content: Text("Are you sure you want to logout?",
              style: TextStyle(color: Vx.white),
            ),
            
            actions:  [
                TextButton(onPressed: ()async {
                  await signOut();
                  // await Future.delayed(Duration(seconds: 1));
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MyRoutes.loginRoute);
                },

                  child: Text("Yes",
                  style: TextStyle(color: MyTheme.fontColor, fontWeight: FontWeight.bold),
                  )),

                  SizedBox(width: MediaQuery.of(context).size.width*0.17,),
            
            TextButton(onPressed: (){
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
              child: Text("No",
              style: TextStyle(color: MyTheme.fontColor, fontWeight: FontWeight.bold)
              )),
            ],
          );
        }
      );
    }
}