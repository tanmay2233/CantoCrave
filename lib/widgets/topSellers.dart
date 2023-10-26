import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Theme/themes.dart';
import 'addToCart.dart';

class TopSellers extends StatelessWidget {
  TopSellers({super.key});

  List<int> ids = [
    23,
    12,
    14,
    1,
    24,
    2,
    3,
    8,
    9,
    18,
    30,
    19,
    11,
    21,
    31,
    34,
    59,
    61,
    79,
    80,
    85
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Menu_Items').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(color: MyTheme.fontColor);
          }
          // Filter documents based on item IDs
          var filteredDocs = snapshot.data!.docs
              .where((doc) => ids.contains(doc.get('itemId'))).toList();

          return SizedBox(
            height: size.height * 0.25,
            child: GridView.builder(
                itemCount: filteredDocs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  int availableQty = filteredDocs[index]['quantity'].toInt();
                return Padding(
                    padding: EdgeInsets.all(size.width * 0.018),
                    child: Stack(
                      children: [Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.iconColor,
                                width: size.height * 0.001),
                            borderRadius:
                                BorderRadius.circular(size.width * 0.05),
                            gradient: LinearGradient(
                                colors: [
                                  MyTheme.canvasDarkColor,
                                  MyTheme.canvasLightColor
                                ],
                                begin: AlignmentDirectional.bottomCenter,
                                end: Alignment.topCenter)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                              image: NetworkImage(filteredDocs[index]['image']),
                              height: size.height * 0.12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      filteredDocs[index]['name'],
                                      maxLines: 3,
                                      style: TextStyle(color: MyTheme.fontColor),
                                    )),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.crop_square_sharp,
                                          color: filteredDocs[index]['isVeg']
                                              ? Colors.green
                                              : const Color.fromARGB(
                                                  202, 243, 57, 44),
                                          size: size.width * 0.06,
                                        ),
                                        Icon(Icons.circle,
                                            color: filteredDocs[index]['isVeg']
                                                ? Colors.green
                                                : const Color.fromARGB(
                                                    202, 243, 57, 44),
                                            size: size.width * 0.024),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹ ${filteredDocs[index]['price'].toInt()}',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    AddToCartButtonPage(
                                        name: filteredDocs[index]['name'],
                                        price:
                                            filteredDocs[index]['price'].toDouble(),
                                        image: filteredDocs[index]['image'],
                                        isVeg: filteredDocs[index]['isVeg'],
                                        availableQty: availableQty.toInt(),
                                        id: filteredDocs[index]['itemId'],
                                        ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      (filteredDocs[index]['quantity'] == 0)
                                  ? Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 34, 9, 9)
                                              .withOpacity(0.5)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Not Available",
                                            style: TextStyle(
                                                color: MyTheme.cardColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.04)),
                                      ),
                                    )
                                  : Container()
                            ],
                    ));
                } 
            )
          );
        });
  }
}
