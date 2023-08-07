import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme/themes.dart';

class CheckoutButton extends StatelessWidget {
  CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: (){},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Vx.blue100,
            border: Border.all(),
            borderRadius: BorderRadius.circular(size.width*0.05),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 208, 0),
              Color.fromARGB(255, 252, 248, 50)
            ])
          ),
          width: size.width*0.5,
          height: size.height*0.05,
          child: Text("Checkout", style: TextStyle(color: MyTheme.canvasDarkColor,
            fontWeight: FontWeight.bold,
            fontSize: size.width*0.037
          ),)
        ),
      );
  }
}