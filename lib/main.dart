// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_list_provider.dart';
import 'package:flutter_firebase/pages/beverages_page.dart';
import 'package:flutter_firebase/pages/chinese_page.dart';
import 'package:flutter_firebase/pages/maggie_omelette_page.dart';
import 'package:flutter_firebase/pages/bottomBar_page.dart';
import 'package:flutter_firebase/pages/burgers&sandwiches_page.dart';
import 'package:flutter_firebase/pages/cart_page.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:flutter_firebase/pages/login_page.dart';
import 'package:flutter_firebase/pages/noodles_page.dart';
import 'package:flutter_firebase/pages/profile_page.dart';
import 'package:flutter_firebase/pages/rolls_page.dart';
import 'package:flutter_firebase/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'widget_tree.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.zenOldMincho().fontFamily,
        ),
        title: 'Flutter Demo',
        routes: {
          MyRoutes.loginRoute: (context) => LoginPage(),
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
        },
        initialRoute: MyRoutes.bottomBar,
        // home: const WidgetTree(),
      ),
    );
  }
}
