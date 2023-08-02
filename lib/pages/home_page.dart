// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/categories.dart';
import '../Theme/themes.dart';
import 'package:card_swiper/card_swiper.dart';

import '../auth.dart';

class HomePage extends StatefulWidget {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User Email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: Text("Sign Out"));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _categoryCardMapList = [
    'images/food_items/noodles.png',
    'images/food_items/burger.png',
    'images/food_items/beverages.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: TextStyle(color: MyTheme.fontColor, fontSize: 30)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                CategoriesPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
