// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/cart_page.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:flutter_firebase/pages/profile_page.dart';

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
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.47,
        backgroundColor: MyTheme.canvasDarkColor,
      ),
      appBar: AppBar(
        title: Text(_buttonList[_selectedButton]['title']),
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
                size: MediaQuery.of(context).size.width * 0.07),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box,
                size: MediaQuery.of(context).size.width * 0.07),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart,
                size: MediaQuery.of(context).size.width * 0.07),
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
