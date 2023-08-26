// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../Theme/themes.dart';
import '../widgets/addToCart.dart';
import '../widgets/cart_total.dart';

class CategoryDetailPage extends StatefulWidget {
  final String title;
  final String category;

  CategoryDetailPage({Key? key, required this.category, required this.title});
  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryDetailWidget(title: widget.title, category: widget.category);
  }

  Widget CategoryDetailWidget(
      {required String title, required String category}) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: MyTheme.fontColor),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomBar(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
                  begin: Alignment.topCenter)),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Menu_Items')
                    .where('categories', isEqualTo: widget.category)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: MyTheme.fontColor,
                    ));
                  }
                  List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(size.width * 0.018),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Image(
                                    image:
                                      NetworkImage(documents[index]['image']),
                                    height: size.height * 0.114,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.01,
                                              right: size.width * 0.01),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                documents[index]['name'],
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: MyTheme.fontColor,
                                                    fontSize:
                                                        size.width * 0.0248,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                              )),
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.crop_square_sharp,
                                                    color: documents[index]
                                                            ['isVeg']
                                                        ? Colors.green
                                                        : const Color.fromARGB(
                                                            202, 243, 57, 44),
                                                    size: size.width * 0.06,
                                                  ),
                                                  Icon(Icons.circle,
                                                      color: documents[index]
                                                              ['isVeg']
                                                          ? Colors.green
                                                          : const Color
                                                                  .fromARGB(
                                                              202, 243, 57, 44),
                                                      size: size.width * 0.024),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              '₹ ${documents[index]['price'].toInt()}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            AddToCartButtonPage(
                                                name: documents[index]['name'],
                                                price: documents[index]['price']
                                                    .toDouble(),
                                                image: documents[index]['image'],
                                                isVeg: documents[index]['isVeg']),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              (documents[index]['quantity'] == 0)
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
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
