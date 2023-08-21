import 'package:flutter/material.dart';
import 'package:flutter_firebase/Theme/themes.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            MyTheme.canvasDarkColor,MyTheme.canvasLightColor, MyTheme.cardColor
          ],
          begin: Alignment.bottomLeft
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: (){}, child: 
            Text("Login with Google"),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyTheme.canvasDarkColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              shadowColor: MyTheme.canvasLightColor)
            ),
            Image.asset("images/logo.png")
          ],
        ),
      ),
    );
  }
}