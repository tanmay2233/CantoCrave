import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Theme/themes.dart';
import '../cart_list_provider.dart';

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
                          fontSize: size.width * 0.035, color: MyTheme.iconColor)),
                  FutureBuilder(
                    future: value.getCartTotal(),
                    builder: (context, snapshot) {

                    final subtotal = snapshot.data ?? 0;
                    return Text("₹ ${subtotal}",
                        style: TextStyle(
                            fontSize: size.width * 0.035, color: MyTheme.fontColor));
                    }  
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Taxes",
                      style: TextStyle(
                          fontSize: size.width * 0.035, color: MyTheme.iconColor)),
                  Text("₹ 0.0",
                      style: TextStyle(
                          fontSize: size.width * 0.035, color: MyTheme.fontColor))
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
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Vx.white)),
                  FutureBuilder(
                    future: value.getCartTotal(),
                    builder: (context, snapshot) {

                      final total = snapshot.data ?? 0;
                    return Text("₹ ${total}",
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.cardColor));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}