// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/widgets/cart_total.dart';
import 'package:flutter_firebase/widgets/addToCart.dart';

import '../Theme/themes.dart';

class CategoryDetailPage extends StatefulWidget {
  final String title;
  final String category;

  CategoryDetailPage({
    Key? key,
    required this.category, required this.title});
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

  Widget CategoryDetailWidget({required String title, required String category}){
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
    
      bottomNavigationBar: MyBottomBar(),  
    
    
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
                    begin: Alignment.topCenter)),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Menu_Items')
                      .where('categories', isEqualTo: widget.category).snapshots(),

                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
    
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(color: MyTheme.fontColor,));
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
                            child: GridTile(
                                child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Image(
                                      image: NetworkImage(documents[index]['image']),
                                      height: size.height * 0.12,
                                    ),
                                  ],
                                ),
                                GridTileBar(
                                    title: Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            documents[index]['name'],
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: MyTheme.fontColor),
                                          )),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Icon(
                                                Icons.crop_square_sharp,
                                                color: documents[index]['isVeg']
                                                    ? Colors.green
                                                    : const Color.fromARGB(
                                                        202, 243, 57, 44),
                                                size: size.width * 0.06,
                                              ),
                                              Icon(Icons.circle,
                                                  color: documents[index]['isVeg']
                                                      ? Colors.green
                                                      : const Color.fromARGB(
                                                          202, 243, 57, 44),
                                                  size: size.width * 0.024),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    subtitle: DecreaseQtyButton(name: documents[index]['name'], 
                                      price: documents[index]['price'].toDouble(), 
                                      image: documents[index]['image'],
                                      isVeg: documents[index]['isVeg'],)
                                  ),
                              ],
                            )),
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
