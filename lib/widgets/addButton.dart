// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme/themes.dart';
import '../cart_model.dart';


class AddButton extends StatefulWidget {
  final String name;
  final double price;

  const AddButton({required this.name, required this.price});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
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
