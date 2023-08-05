// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/routes/routes.dart';

import '../Theme/themes.dart';
import '../cart_model.dart';

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
        )  
      ),

      bottomNavigationBar: BottomAppBar(
        color: MyTheme.canvasDarkColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text("₹ ${CartModel.getCartTotal()}", style: TextStyle(color: MyTheme.fontColor, 
            fontWeight: FontWeight.bold, fontSize: size.width*0.0475)),

            Container(
              decoration: BoxDecoration(color: MyTheme.fontColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(size.width*0.02))
              ),
              width: size.width*0.5,
              child: ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, MyRoutes.cartRoute);
                },
                style: ElevatedButton.styleFrom(backgroundColor: MyTheme.fontColor, elevation: 0.0),
              
                child: Text("Go to Cart", style: TextStyle(color: MyTheme.canvasDarkColor, fontWeight: FontWeight.bold))
              ),
            )
          ],
        ),
      ),

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
                stream: FirebaseFirestore.instance
                    .collection('Menu_Items').where('categories', isEqualTo: widget.category).snapshots(),
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
                              Image(
                                image: NetworkImage(documents[index]['image']),
                                height: size.height * 0.12,
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
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: MyTheme.fontColor),
                                        )),
                                        // documents[index]['isVeg']? Image.asset("images/veg.png", width: size.width*0.03):
                                        // Image.asset("images/nonveg.png",width: size.width * 0.03)
                                      ],
                                    ),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹ ${documents[index]['price']}',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      (
                                      CartModel.getItemQuantity(documents[index]['name']) == 0 ) ? 
                                      IconButton(onPressed: (){
                                        setState(() {
                                          CartModel.addToCart(documents[index]['name'],
                                              documents[index]['price'].toDouble(), 1);
                                        });
                                      } , 
                                        icon: Icon(CupertinoIcons.add_circled_solid, 
                                        color: MyTheme.iconColor,
                                        )
                                      ):
                                      Row(children: [
                                        IconButton(onPressed: () => setState(() {
                                          CartModel.removeItem(documents[index]['name']);
                                        }),
                                        icon: Icon(Icons.remove_circle_outline_sharp)
                                        ),

                                        Text(CartModel.getItemQuantity(documents[index]['name']).toString()),
                                        
                                        IconButton(
                                          onPressed: () => setState(() {
                                            CartModel.removeItem(documents[index]['name']);
                                          }),
                                          icon: IconButton(onPressed: () => setState(() {
                                            CartModel.addToCart(documents[index]['name'], documents[index]['price'].toDouble(), 1);
                                          }),
                                          icon: Icon(Icons.add_circle_outline_sharp))),
                                      ])
                                    ],
                                  )
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
