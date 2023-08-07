import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Theme/themes.dart';

class CartCalculations extends StatelessWidget {
  const CartCalculations({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CartListProvider>(
      builder: (context, value, child) => 
      Padding(
        padding: EdgeInsets.all(size.width*0.1),
        child: Container(
          
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal",
                      style: TextStyle(
                          fontSize: size.width * 0.04, color: MyTheme.iconColor)),
                  Text("₹ ${value.getCartTotal()}",
                      style: TextStyle(
                          fontSize: size.width * 0.04, color: MyTheme.fontColor))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Taxes",
                      style: TextStyle(
                          fontSize: size.width * 0.04, color: MyTheme.iconColor)),
                  Text("₹ 0.0",
                      style: TextStyle(
                          fontSize: size.width * 0.04, color: MyTheme.fontColor))
                ],
              ),
              Divider(
                height: size.height * 0.02,
                color: MyTheme.cardColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                      style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Vx.white)),
                  Text("₹ ${value.getCartTotal()}",
                      style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.cardColor))
                ],
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Vx.blue100,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(size.width*0.05),
                    gradient: const LinearGradient(colors: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}