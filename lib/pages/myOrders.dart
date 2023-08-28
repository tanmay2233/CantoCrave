import 'package:canto_crave/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Theme/themes.dart';

class MyOrdersPage extends StatefulWidget {
  MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacementNamed(context, MyRoutes.bottomBar);
        return false;
      },
      child: Scaffold(
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
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
              ),
            ),
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('orders').doc(user!.uid).
                collection('orderHistory').orderBy('orderDate', descending: true)
                .snapshots(),
              builder: (context, snapshot) {
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: MyTheme.cardColor);
                } 
                else if (snapshot.hasData) {
                  final orderDocs = snapshot.data!.docs;
            
                  if (orderDocs.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("No orders Placed Till Now !!",
                        textAlign: TextAlign.center,
                          style: TextStyle(
                            color: MyTheme.iconColor, fontSize: size.width * 0.065)),
                        Image.asset("images/logo.png", width: size.width * 0.3)]);
                  }
            
                  return ListView.builder(
                    itemCount: orderDocs.length,
                    itemBuilder: (context, index1) {
            
                    final orderData =
                      orderDocs[index1].data() as Map<String, dynamic>;
                      final orderId = orderDocs[index1].id;
                      var formattedDate = '';
                      if (orderData.containsKey('orderDate') &&
                              orderData['orderDate'] != null) {
                            final orderDate = orderData['orderDate'] as Timestamp;
                            formattedDate = DateFormat('EEEE d MMM, y')
                                .format(orderDate.toDate());
                            // Use formattedDate as needed
                          }
            
                      final items = orderData['items'] as List<dynamic>;
                      double total = 0;
            
                      for(var orderedItem in items){
                        total += orderedItem['quantity']*orderedItem['price'].toDouble().toDouble();
                      }
            
                      return Padding(
                        padding: EdgeInsets.all(size.width*0.06),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.width * 0.003),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(formattedDate,
                                  style: TextStyle(color: Colors.white, 
                                  fontWeight: FontWeight.bold)
                                  ),
                                  Text('Order Id: ${orderId}',
                                  style: TextStyle(color: MyTheme.iconColor, 
                                  fontWeight: FontWeight.bold)
                                  ),
                                ],
                              ),
                            ),
                            
                                ListView.builder(
                                  shrinkWrap : true,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
            
                                    final item = items[index] as Map<String, dynamic>;
            
                                    return Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(size.width*0.05),
                                          gradient: LinearGradient(
                                            colors: [
                                              MyTheme.canvasDarkColor, MyTheme.canvasLightColor
                                            ])),
                                        child: Padding(
                                          padding: EdgeInsets.all(size.width*0.01),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.network(item['image'],
                                                width: size.width*0.12,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    item['name'],
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(color: MyTheme.cardColor),
                                                  ),
                                                  Text(
                                                    "${item['quantity'].toString()} unit(s)" ,
                                                    style: TextStyle(color: MyTheme.iconColor))
                                                ]
                                              ),
                                              Text(
                                                "₹ ${item['price'].toString()}" ,
                                                style: TextStyle(color: Colors.white))
                                            ]
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                            Padding(
                              padding: EdgeInsets.all(size.width*0.02),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Order Toatl:  ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                    Text("₹ ${total.toString()}", 
                                      style: TextStyle(color: MyTheme.fontColor,
                                        fontWeight: FontWeight.bold
                                      )),
                                  ],
                                )),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                else {
                  return Container();
                }
                    }),
            ),
          )
    
      ),
    );
  }
}