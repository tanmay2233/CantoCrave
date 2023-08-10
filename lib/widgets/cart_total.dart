import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_list_provider.dart';
import 'package:flutter_firebase/pages/cart_page.dart';
import 'package:provider/provider.dart';

import '../Theme/themes.dart';
import '../routes/routes.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CartListProvider>(
      builder: (context, value, child) => BottomAppBar(
        color: MyTheme.canvasDarkColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("₹ ${value.getCartTotal()}",
                style: TextStyle(
                    color: MyTheme.fontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.0475)),
            Container(
              decoration: BoxDecoration(
                  color: MyTheme.fontColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(size.width * 0.02))),
              width: size.width * 0.5,
              child: ElevatedButton(
                  onPressed: () {
                    // Define the custom slide transition
                    var customPageRoute = PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return CartPage(); // Replace with the widget for the second page
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        // Use a Tween to control the slide animation
                        var tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);

                        // Use a CurvedAnimation to control the easing curve
                        var curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve:
                              Curves.easeInOut, // Choose your preferred curve
                        );

                        // Apply the slide transition
                        return SlideTransition(
                          position: tween.animate(curvedAnimation),
                          child: child,
                        );
                      },
                      transitionDuration: Duration(seconds: 1),
                    );

                    Navigator.of(context).push(customPageRoute);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.fontColor, elevation: 0.0),
                  child: Text("Go to Cart",
                      style: TextStyle(
                          color: MyTheme.canvasDarkColor,
                          fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }
}
