// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields, unused_element

import 'package:flutter/material.dart';
import '../Theme/themes.dart';
import 'package:card_swiper/card_swiper.dart';

import '../widgets/topSellers.dart';
import 'categories.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _categoryCardMapList = [
    'images/food_items/noodles.png',
    'images/food_items/burger.png',
    'images/food_items/beverages.png',
    'images/food_items/Maggie-Omelette.jpeg'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
                    begin: Alignment.topCenter)),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.33,
                      child: Swiper(
                        itemCount: _categoryCardMapList.length,
                        autoplay: true,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            _categoryCardMapList[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              activeColor: MyTheme.fontColor,
                            )),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    Text("Categories",
                        style: TextStyle(color: MyTheme.fontColor, fontSize: MediaQuery.of(context).size.width*0.085,
                        fontWeight: FontWeight.bold
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                    CategoriesPage(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Text("Top Sellers",
                        style: TextStyle(color: MyTheme.fontColor,
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                            fontWeight: FontWeight.bold)),
    
                    SizedBox(height: size.height*0.025),
    
                    TopSellers(),
                    SizedBox(height: size.height*0.04,)
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
