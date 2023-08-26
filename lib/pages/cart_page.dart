// ignore_for_file: use_key_in_widget_constructors, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Theme/themes.dart';
import '../cart_list_provider.dart';
import '../widgets/cartEmpty.dart';
import '../widgets/cart_tiles.dart';
import '../widgets/checkoutButton.dart';

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
        
        child:  CartListTiles()),
        
      bottomNavigationBar: Consumer<CartListProvider>(
        builder: (context, value, child) => 
        FutureBuilder(
          future: value.getCartTotal(),
          builder: (context, snapshot) {
            double total = snapshot.data ?? 0.0;
            if(total > 0){
              return BottomAppBar(
                elevation: 0.0,
                color: MyTheme.canvasDarkColor,
                child: CheckoutButton(),
              );
            }
            else{
              return CartEmpty();
            }
          },
        )
        // const CartEmpty()
      ),
      
    );
  }
}