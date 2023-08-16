// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_list_provider.dart';
import 'package:flutter_firebase/cart_model.dart';
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

            FutureBuilder<bool>(
              future: value.checkCartItem(widget.name),
              builder: (context, snapshot){
                  final itemExists = snapshot.data ?? false;
                  if (itemExists) {
                    return Row(children: [
                      IconButton(
                          onPressed: () async =>
                            await value.decreaseQuantity(widget.name),
                          icon: const Icon(Icons.remove_circle_outline_sharp)),

                      FutureBuilder(
                        future: value.getItemQuantity(widget.name),
                        builder: (context, snapshot) {

                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                            
                          final quantity = snapshot.data ?? 0;

                          return Text(
                          quantity.toString(),
                            style: TextStyle(color: Colors.white),
                          );
                        },),

                      IconButton(
                          onPressed: () async =>
                              await value.decreaseQuantity(widget.name),
                          icon: IconButton(
                              onPressed: () async => await value.addToCart(
                                CartModel(
                                  widget.name, widget.price.toDouble(), 1,
                                  widget.image, widget.isVeg)),
                              icon:
                                const Icon(Icons.add_circle_outline_sharp))),
                    ]);
                  }
                  else{
                    return InkWell(
                        onTap: () async {
                          await value.addToCart(CartModel(
                            widget.name,
                            widget.price.toDouble(), 1,
                            widget.image, widget.isVeg,
                          ));
                        },
                        child: Icon(
                          CupertinoIcons.add_circled_solid,
                          color: MyTheme.iconColor,
                    ));
                  }
          })
        ],
      ),
    ) ; 
  }
}
