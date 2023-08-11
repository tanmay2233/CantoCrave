import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Theme/themes.dart';
import '../myOrdersModel.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(color: MyTheme.fontColor),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
          ),
        ),
      ),

      body: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
            ),
          ),
          child: ListView.builder(
            itemCount: MyOrders.getMyOrderList().length, // Use the length of the outer list
            itemBuilder: (context, index1) {
              final ordersAtIndex1 = MyOrders.getMyOrderList()[index1];
              return Padding(
                padding: EdgeInsets.all(size.width*0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: MyTheme.cardColor)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.003),
                        child: Text(
                          DateFormat.yMd().add_jm().format(DateTime.now()),
                        style: TextStyle(color: MyTheme.iconColor, 
                        fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap : true,
                      itemCount: ordersAtIndex1.length,
                      itemBuilder: (context, index) {
                        final orderItem = ordersAtIndex1[index];
                        return Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(size.width*0.05),
                              gradient: LinearGradient(
                                colors: [
                                  MyTheme.canvasDarkColor,
                                  MyTheme.canvasLightColor
                                ])),
                            child: Padding(
                              padding: EdgeInsets.all(size.width*0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(orderItem.image,
                                    width: size.width*0.12,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        orderItem.name,
                                        style: TextStyle(color: MyTheme.cardColor),
                                      ),
                                      Text(
                                        "${orderItem.quantity.toString()} unit(s)" ,
                                        style: TextStyle(color: MyTheme.iconColor),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹ ${orderItem.price.toString()}" ,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.width*0.02),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text("₹ ${MyOrders.getOrderTotal(index1)}", 
                          style: TextStyle(color: MyTheme.fontColor,
                            fontWeight: FontWeight.bold
                          ))),
                    )
                  ],
                ),
              );
            },
          ),
        )

    );
  }
}