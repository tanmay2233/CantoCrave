// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Theme/themes.dart';

import '../cart_model.dart';

class AddToCartButton extends StatefulWidget {

  String name = '';
  double price = 0;
  int qty = 0;
  AddToCartButton({super.key, required this.name, required this.price, required this.qty});

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            CartModel.addToCart(widget.name, widget.price, 1);
          });
        },
        icon: Icon(
          CupertinoIcons.add_circled_solid,
          color: MyTheme.iconColor,
        ));
  }
}
