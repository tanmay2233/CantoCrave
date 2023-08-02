import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../Theme/themes.dart';

class BurgerSandwichPage extends StatefulWidget {
  const BurgerSandwichPage({super.key});

  @override
  State<BurgerSandwichPage> createState() => _BurgerSandwichPageState();
}

class _BurgerSandwichPageState extends State<BurgerSandwichPage> {
  List<String> imageUrls = [];
  List<Map<String, dynamic>> _burgerSandwichList = [];
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }


  DocumentReference _getCategoryReference(String categoryID) {
    return FirebaseFirestore.instance.doc('/Menu_Categories/$categoryID');
  }

  Future<List<Map<String, dynamic>>> getImageUrls() async {
    final List<String> imageUrls = await Future.wait([
      storage.ref().child('veg_burger.png').getDownloadURL(),
      storage.ref().child('chicken_burger.png').getDownloadURL(),
      storage.ref().child('veg_cheese_burger.png').getDownloadURL(),
      storage.ref().child('chicken_cheese_burger.png').getDownloadURL(),
      storage.ref().child('paneer_sandwich.png').getDownloadURL(),
    ]);

    return [
      {'image': NetworkImage(imageUrls[0])},

      {'image': NetworkImage(imageUrls[1])},

      {'image': NetworkImage(imageUrls[2])},

      {'image': NetworkImage(imageUrls[3])},

      {'image': NetworkImage(imageUrls[4])},
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Burgers & Sandwiches", 
          style: TextStyle(color: MyTheme.fontColor
          ),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
                  begin: Alignment.topCenter)),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: getImageUrls(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: MyTheme.fontColor));
              }
              
              else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } 
              
              else {
                _burgerSandwichList = snapshot.data!;

                return Column(
                  children: [
                    SizedBox(height: size.height*0.04),
                    
                    SizedBox(height: size.height * 0.03),

                    StreamBuilder<QuerySnapshot>(
                      
                      stream: FirebaseFirestore.instance.collection('Menu_Items').where('Category', isEqualTo: _getCategoryReference('2')).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                        
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final item = _burgerSandwichList[index];
                          return Padding(
                            padding: EdgeInsets.all(size.width*0.018),
                            child: GridTile(
                              child: Column(
                                children: [
                                  Image(image: item['image'], height: size.height*0.12,),
                              GridTileBar(
                                title: Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(documents[index]['Name']
                                      ,maxLines: 2, style: TextStyle(color: MyTheme.fontColor),)),
                                      Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.crop_square_sharp,
                                              color: documents[index]['isVeg']
                                                  ? Colors.green
                                                  : const Color.fromARGB(202, 243, 57, 44),
                                              size: size.width * 0.06,
                                            ),
                                            Icon(Icons.circle,
                                                color: documents[index]['isVeg']
                                                    ? Colors.green
                                                    : const Color.fromARGB(
                                                        202, 243, 57, 44),
                                                size: size.width * 0.024),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('₹ ${documents[index]['Price']}', 
                                    style: const TextStyle(color: Colors.white),
                                    ),
                    
                                    Icon(Icons.add_circle, color: MyTheme.iconColor)
                                  ],
                                )
                              ),
                            ],
                            )
                            ),
                          );
                        },
                      ),
                    );
                      },
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}