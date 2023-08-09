import 'package:flutter/material.dart';
import 'package:flutter_firebase/Theme/themes.dart';
import 'package:flutter_firebase/routes/routes.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Admin Page", style: 
      TextStyle(color: MyTheme.fontColor),),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            MyTheme.canvasLightColor,
            MyTheme.canvasDarkColor
        ]))
      )),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            MyTheme.canvasLightColor,
            MyTheme.canvasDarkColor
          ])
        ),
        
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width*0.5,
              height: size.height*0.05,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, MyRoutes.editItemPageRoute);
                }, 
                child: Text("Edit Item"),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder()
                )),
            ),
            Container(
              width: size.width * 0.5,
              height: size.height * 0.05,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Add New Item"),
                style: ElevatedButton.styleFrom(shape: StadiumBorder())),
            )
          ],
        )),
      ),
    );
  }
}