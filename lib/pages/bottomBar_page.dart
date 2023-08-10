// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_list_provider.dart';
import 'package:flutter_firebase/pages/cart_page.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:flutter_firebase/pages/profile_page.dart';
import 'package:flutter_firebase/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Theme/themes.dart';

class BottomBarPage extends StatefulWidget {
  @override
  State<BottomBarPage> createState() => _BottomBarPage();
}

class _BottomBarPage extends State<BottomBarPage> {
  List<Map<String, dynamic>> _buttonList = [
    {"page": HomePage(), "title": "Home Page"},
    {"page": ProfilePage(), "title": "Profile Page"},
    {"page": CartPage(), "title": "Cart Page"},
  ];

  int _selectedButton = 0;

  void _changeButton(int index) {
    setState(() {
      _selectedButton = index;
    });
  }

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("images/logo.png", width: size.width*0.1),
            Text(_buttonList[_selectedButton]['title'], textAlign: TextAlign.center),

            // Cart Icon

            Consumer<CartListProvider>(
              builder: (context, value, child) => 
              (value.cartList.length > 0)?
              Badge(
                alignment: Alignment.topRight,
                backgroundColor: MyTheme.cardColor,
                textColor: MyTheme.canvasDarkColor,
                label: Text(value.cartList.length.toString()),
                child: Padding(
                  padding: EdgeInsets.all(size.width*0.01),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
                    child: Icon(CupertinoIcons.cart)),
                )
                ):
                InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRoutes.cartRoute),
                    child: Icon(CupertinoIcons.cart)),
            )
          ]
        ),  
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
          ),
        ),  
      ),    
      body: _buttonList[_selectedButton]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: size.width * 0.07),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box,
                size: size.width * 0.07),
            label: "Search"
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart,
                size: size.width * 0.07),
            label: "Cart",
          )
        ],
        currentIndex: _selectedButton,
        onTap: _changeButton,
        backgroundColor: MyTheme.canvasDarkColor,
        selectedIconTheme: IconThemeData(
          color: MyTheme.selectedIconColor,
        ),
        unselectedIconTheme: IconThemeData(color: MyTheme.unselectedIconColor),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: MyTheme.selectedIconColor,
        unselectedItemColor: MyTheme.unselectedIconColor,
      ),
    );
  }
}
