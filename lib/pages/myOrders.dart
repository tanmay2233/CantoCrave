import 'package:flutter/material.dart';

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
            colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor])
        ),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index1) => 
          ListView.builder(
            itemCount: MyOrders.getMyOrderList()[index1].length,
            itemBuilder: (context, index) => 
              SizedBox(
                height: size.height*0.1,
                child: Row(
                  children: [
                      Column(
                        children: [
                          Text(MyOrders.getMyOrderList()[index1][index].name, 
                            style: TextStyle(color: MyTheme.cardColor)),
                          Text(MyOrders.getMyOrderList()[index1][index].price.toString(),
                            style: TextStyle(color: Colors.white))
                        ],
                      ),
                      Text(
                        MyOrders.getMyOrderList()[index1][index].quantity.toString(),
                        style: TextStyle(color: MyTheme.cardColor))
                  ],
                )))
        )
      ),
    );
  }
}