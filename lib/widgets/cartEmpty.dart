import 'package:flutter/material.dart';

import '../Theme/themes.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: Text("Cart is Empty!!",
                    style: TextStyle(
                        color: MyTheme.iconColor, fontSize: size.width * 0.065))),
            Image.asset("images/logo.png", width: size.width * 0.3)
          ],
        ),
      ),
    );
  }
}