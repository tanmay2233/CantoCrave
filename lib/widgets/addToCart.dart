// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, sort_child_properties_last, use_build_context_synchronously
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/themes.dart';
import '../cart_list_provider.dart';
import '../cart_model.dart';

class AddToCartButtonPage extends StatefulWidget {
  final String name, image;
  double price;
  bool isVeg;
  int availableQty, id;

  // ignore: use_key_in_widget_constructors
  AddToCartButtonPage(
      {required this.name,
      required this.price,
      required this.image,
      required this.isVeg,
      required this.availableQty,
      required this.id});

  @override
  State<AddToCartButtonPage> createState() => _AddToCartButtonPageState();
}

class _AddToCartButtonPageState extends State<AddToCartButtonPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.01, right: size.width * 0.01),
      child: Consumer<CartListProvider>(
        builder: (context, value, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<bool>(
                future: value.checkCartItem(widget.id),
                builder: (context, snapshot) {
                  final itemExists = snapshot.data ?? false;
                  if (itemExists) {
                    return Row(children: [
                      IconButton(
                          onPressed: () async =>
                              await value.decreaseQuantity(widget.id),
                          icon: const Icon(Icons.remove_circle_outline_sharp,
                              color: Colors.white)),
                      FutureBuilder(
                        future: value.getItemQuantityFromCart(widget.id),
                        builder: (context, snapshot) {
                          final quantity = snapshot.data ?? 0;

                          return Text(
                            quantity.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      IconButton(
                          onPressed: () async =>
                              await value.decreaseQuantity(widget.id),
                          icon: IconButton(
                              onPressed: () async {
                                if (widget.availableQty >
                                    await value
                                        .getItemQuantityFromCart(widget.id)) {
                                  await value.addToCart(CartModel(
                                      widget.name,
                                      widget.price.toDouble(),
                                      1,
                                      widget.image,
                                      widget.isVeg,
                                      widget.id
                                      ));
                                } else {
                                  var snackBar = SnackBar(
                                      content: Text(
                                          'No More ${widget.name} Available'),
                                      duration: const Duration(seconds: 2),
                                      action: SnackBarAction(
                                          label: '', onPressed: () {}));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              icon: const Icon(Icons.add_circle_outline_sharp,
                                  color: Colors.white))),
                    ]);
                  } else {
                    return ElevatedButton(
                      child: Row(
                        children: [
                          Icon(Icons.add, color: MyTheme.canvasLightColor),
                          Text("Add",
                              style: TextStyle(
                                  color: MyTheme.canvasDarkColor,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      onPressed: () async {
                        await value.addToCart(CartModel(
                          widget.name,
                          widget.price.toDouble(),
                          1,
                          widget.image,
                          widget.isVeg,
                          widget.id
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: MyTheme.cardColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.1))),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
