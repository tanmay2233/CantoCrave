import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_model.dart';
import 'package:flutter_firebase/widgets/cartCalculations.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Theme/themes.dart';
import '../cart_list_provider.dart';

class CartListTiles extends StatelessWidget {
  CartListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<CartListProvider>(
          builder: (context, value, child) => 

          FutureBuilder(
            future: value.getCartItems(),
            builder: (context, snapshot) {

            final cartItems = snapshot.data ?? [];

              return (cartItems.isNotEmpty) ? CustomScrollView(        
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                      children: [
                    
                        SizedBox(height: size.height*0.02),
                    
                        Text("Item(s) Added", 
                        style: TextStyle(color: MyTheme.fontColor, fontSize: size.width*0.055)),
                    
                        SizedBox(height: size.height*0.038),
                      ],
                  ),
                ),
              
                SliverList.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) =>  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.03,
                        right: size.width * 0.03,
                        bottom: size.height * 0.0065),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              size.width * 0.07)),
                      color: MyTheme.canvasDarkColor,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.black,
                            MyTheme.canvasLightColor,
                          ]),
                            borderRadius: BorderRadius.circular(
                                size.width * 0.07),
                            border: Border.all(
                                color: const Color.fromARGB(
                                    179, 172, 169, 169))),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 0.02),
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                              children: [
                                Image.network(
                                  cartItems[index]['image'],
                                  width: size.width * 0.3,
                                  height: size.height*0.1,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceAround,
                                      children: [
                                        Container(
                                          constraints:
                                              BoxConstraints(
                                                  maxWidth:
                                                      size.width *
                                                          0.26),
                                          child: Text(
                                            cartItems[index]['name'] + " ",
                                            style: TextStyle(
                                                color: MyTheme.fontColor),
                                            maxLines: 4,
                                          ),
                                        ),
                                        Stack(
                                          alignment:
                                            Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.crop_square_sharp,
                                              color: cartItems[index]['isVeg']
                                                ? Colors.green
                                                : const Color.fromARGB(
                                                202,243,57, 44),
                                              size: size.width * 0.06
                                            ),
                                            Icon(Icons.circle,
                                              color: cartItems[index]['isVeg']
                                                ? Colors.green
                                                : const Color.fromARGB(
                                                202, 243, 57, 44),
                                              size: size.width * 0.024),
                                      ])]
                                    ),
                                    Text(
                                      "₹ ${cartItems[index]['price']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () => value.decreaseQuantity(cartItems[index]['name']),
                                        child: Icon(
                                          Icons.remove,
                                          color: MyTheme.iconColor,
                                          size: size.width * 0.055)),
                                      Text(
                                        cartItems[index]['quantity'].toString(),
                                        style: TextStyle(color: Vx.white),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                          value.addToCart(
                                            CartModel(
                                                                cartItems[index]
                                                                    ['name'],
                                            cartItems[index]
                                                                    ['price'],
                                            cartItems[index]
                                                                    ['quantity'],
                                            cartItems[index]
                                                                    ['image'],
                                            cartItems[index]
                                                                    ['isVeg'])),
                                        child: Icon(Icons.add,
                                          color: MyTheme.iconColor,
                                          size: size.width * 0.055)),
                                    ],
                                  ),
                                ),
                              ])),
                        ),
                      ),
                    ),
                  )),
                const SliverToBoxAdapter(
                  child:
                    CartCalculations()
                )
              ],
            ):
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(child: Text("Cart is Empty!!", 
              style: TextStyle(color: MyTheme.iconColor,
              fontSize: size.width*0.065
              ))),
              Image.asset("images/logo.png",
              width: size.width*0.3
              )
            ],
          );
            }
          ) 
          
        );

  }
}