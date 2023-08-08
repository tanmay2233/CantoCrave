// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_list_provider.dart';
import 'package:flutter_firebase/widgets/cartEmpty.dart';
import 'package:flutter_firebase/widgets/cart_tiles.dart';
import 'package:flutter_firebase/widgets/checkoutButton.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Theme/themes.dart';

class CartPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart", style: TextStyle(color: Vx.white)),
      flexibleSpace: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
        )),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
            begin: Alignment.topCenter)),
        
        child: const CartListTiles()),
        
      bottomNavigationBar: Consumer<CartListProvider>(
        builder: (context, value, child) => 
        (value.getCartTotal() > 0)?
        BottomAppBar(
          elevation: 0.0,
          color: MyTheme.canvasDarkColor,
          child: CheckoutButton(),
        ):
        CartEmpty()
      ),
      
    );
  }
}