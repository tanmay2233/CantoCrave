// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_list_provider.dart';
import 'package:provider/provider.dart';
import '../Theme/themes.dart';

class DecreaseQtyButton extends StatefulWidget {
  final String name, image;
  double price ;
  bool isVeg;

  DecreaseQtyButton({required this.name, required this.price, required this.image, required this.isVeg});

  @override
  State<DecreaseQtyButton> createState() => _DecreaseQtyButtonState();
}

class _DecreaseQtyButtonState extends State<DecreaseQtyButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartListProvider>(
      builder: (context, value, child) => Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '₹ ${widget.price.toInt()}',
            style: const TextStyle(
                color: Colors.white),
            ),
            (value.getItemQuantity(widget.name)) == 0 ?
            InkWell(onTap: (){
              setState(() {
              value.addToCart(widget.name,
                widget.price.toDouble(), 1, widget.image, widget.isVeg);
              });
              }, 
              child: Icon(CupertinoIcons.add_circled_solid, color: MyTheme.iconColor)
          ):
          Row(children: [
                  IconButton(
                    onPressed: () => value.removeItem(widget.name),
                    icon: Icon(Icons
                        .remove_circle_outline_sharp)),
                  Text(value.getItemQuantity(
                          widget.name)
                      .toString()),
                  IconButton(
                      onPressed: () => value.removeItem(
                                widget.name),
                      icon: IconButton(
                          onPressed: () =>
                              value.addToCart(widget.name,
                                    widget.price.toDouble(), 1, widget.image, widget.isVeg),
                          icon: Icon(Icons.add_circle_outline_sharp))),
                ])
        ],
      ),
    ) ; 
  }
}
