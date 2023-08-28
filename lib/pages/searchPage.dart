import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Theme/themes.dart';
import '../cart_list_provider.dart';
import '../widgets/addToCart.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> allItems = [];

  void fetchAllItemsFromFirebase(String query) async {
    final result =
      await FirebaseFirestore.instance.collection('Menu_Items').get();

    setState(() {
      allItems = result.docs.map((e) => e.data()).toList();
      allItems = allItems
          .where((item) => item['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {

  var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
          begin: Alignment.topCenter)),
      
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.width*0.04),
            child: TextField(
              cursorColor: Colors.white,
              style: TextStyle(color: MyTheme.cardColor),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyTheme.iconColor),
                  borderRadius: BorderRadius.circular(size.width*0.04)
                ),
                suffixIcon: Icon(Icons.search_rounded),
                suffixIconColor: MyTheme.fontColor,
                hintText: "Search for an item...",
                hintStyle: TextStyle(color: MyTheme.fontColor),
                focusedBorder: UnderlineInputBorder(borderSide: 
                BorderSide(color: MyTheme.iconColor))
              ),
            
              onChanged: (query) {
                fetchAllItemsFromFirebase(query);
              },
            ),
          ),

          Consumer<CartListProvider>(
            builder: (context, value, child) => 
            Expanded(child: 
              ListView.builder(
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  int availableQty = allItems[index]['quantity'].toInt();
                  return Card(
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
                                    allItems[index]['image'],
                                    width: size.width * 0.2,
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
                                              allItems[index]['name'] + " ",
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
                                                color: allItems[index]['isVeg']
                                                  ? Colors.green
                                                  : const Color.fromARGB(
                                                  202,243,57, 44),
                                                size: size.width * 0.06
                                              ),
                                              Icon(Icons.circle,
                                                color: allItems[index]['isVeg']
                                                  ? Colors.green
                                                  : const Color.fromARGB(
                                                  202, 243, 57, 44),
                                                size: size.width * 0.024),
                                        ])]
                                      ),
                                      Text(
                                        "₹ ${allItems[index]['price']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  AddToCartButtonPage(name: allItems[index]['name'], 
                                    price: allItems[index]['price'].toDouble(), 
                                    image: allItems[index]['image'], 
                                    isVeg: allItems[index]['isVeg'],
                                    availableQty: availableQty)
                                ])),
                          ),
                        ),
                      );
              },)
            ),
          )
        ],
      ),
    );
  }
}