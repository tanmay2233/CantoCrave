import 'package:canto_crave/cart_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
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
              if(index == 0){
                _upperText = "Welcome to CantoCrave";
                _lowerText = "Beat The Crowd & Order Your Favourite Snacks From Your Room";
              }
              else if(index == 1){
                _upperText = "Collect Your Food From Canteen";
                _lowerText = "Let's SignIn Now..";
              }
              return (index < 2) ? Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Text(
                    _upperText,
                    style: TextStyle(
                      color: MyTheme.cardColor, fontSize: size.width * 0.06),
                      textAlign: TextAlign.center
                  ),
                  Image.asset("images/${index + 1}.png"),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Text(
                      _lowerText,
                      style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.04),
                      textAlign: TextAlign.center,
                    ),
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
              :
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('images/logo.png',
                    height: size.height*0.25,),
                  Consumer<CartListProvider>(
                    builder: (context, value, child) => 
                    SizedBox(
                      
                      width: size.width*0.55,
                      child: ElevatedButton(onPressed: () async {
                        try {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(color: MyTheme.cardColor),
                              );
                            },
                          );
                          final user = await AuthService().signInWithGoogle();
                          Navigator.pop(context); 
                          if (user != null) {
                            Navigator.pushNamed(context, MyRoutes.bottomBar);
                          } 
                        } 
                        catch (e) {
                        }
                      },
                      
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: MyTheme.cardColor, 
                          width: size.width*0.006),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(size.width*0.05)
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("images/google_logo.png", height: size.height*0.03,),
                          Text("Login with Google", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyTheme.canvasDarkColor),),
                        ],
                      )),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}