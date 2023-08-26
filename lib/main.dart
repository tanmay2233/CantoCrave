// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:canto_crave/pages/beverages_page.dart';
import 'package:canto_crave/pages/bottomBar_page.dart';
import 'package:canto_crave/pages/burgers&sandwiches_page.dart';
import 'package:canto_crave/pages/cart_page.dart';
import 'package:canto_crave/pages/chinese_page.dart';
import 'package:canto_crave/pages/demo.dart';
import 'package:canto_crave/pages/home_page.dart';
import 'package:canto_crave/pages/maggie_omelette_page.dart';
import 'package:canto_crave/pages/myOrders.dart';
import 'package:canto_crave/pages/noodles_page.dart';
import 'package:canto_crave/pages/profile_page.dart';
import 'package:canto_crave/pages/rolls_page.dart';
import 'package:canto_crave/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'admin/adminPage.dart';
import 'admin/adminSearchPage.dart';
import 'admin/editItemPage.dart';
import 'cart_list_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    
    final user = FirebaseAuth.instance.currentUser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.elMessiri().fontFamily,
        ),
        title: 'Flutter Demo',
        routes: {
          MyRoutes.homeRoute: (context) => HomePage(),
          MyRoutes.cartRoute: (context) => CartPage(),
          MyRoutes.profileRoute: (context) => ProfilePage(),
          MyRoutes.bottomBar: (context) => BottomBarPage(),
          MyRoutes.burgerSandwichRoute: (context) => BurgerSandwichPage(),
          MyRoutes.noodlesRoute: (context) => NoodlesPage(),
          MyRoutes.maggieOmeletteRoute: (context) => MaggieOmelettePage(),
          MyRoutes.chinesePageRoute: (context) => ChinesePage(),
          MyRoutes.beveragesRoute: (context) => BeveragesPage(),
          MyRoutes.rollsPageRoute: (context) => RollsCurriesPage(),
          MyRoutes.adminPageRoute: (context) => AdminPage(),
          MyRoutes.editItemPageRoute: (context) => EditItemPage(),
          MyRoutes.myOrdersPageRoute: (context) => MyOrdersPage(),
          MyRoutes.demoPageRoute: (context) => DemoPage(),
          MyRoutes.adminSearchPageRoute: (context) => AdminSearchPage()
        },
        initialRoute: (user == null)? MyRoutes.demoPageRoute : MyRoutes.bottomBar,
      ),
    );
  }
}
