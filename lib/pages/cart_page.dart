// ignore_for_file: use_key_in_widget_constructors

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme/themes.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
                begin: Alignment.topCenter)),
      ),
    );
  }
}