import 'package:flutter/material.dart';
import 'package:flutter_firebase/routes/routes.dart';

import '../Theme/themes.dart';

class CategoriesPage extends StatelessWidget {

    final List<Map<String, dynamic>> _categoryCardMapList = [
      {'image': 'images/food_items/Maggie-Omelette.jpeg', 
      'text': 'Maggie & Omelettes',
      'route': MyRoutes.maggieOmeletteRoute
      },

      {'image': 'images/food_items/burger.png', 
      'text': 'Burgers & Sandwiches',
      'route': MyRoutes.burgerSandwichRoute
      },

      {'image': 'images/food_items/noodles.png', 
      'text': 'Noodles & Pastas',
      'route': MyRoutes.noodlesRoute
      },

      {'image': 'images/food_items/chinese.png', 
      'text': 'Chinese',
      'route': MyRoutes.chinesePageRoute
      },

      {
      'image': 'images/food_items/rolls.png',
      'text': 'Rolls & Curries',
      'route': MyRoutes.rollsPageRoute
      },

      {'image': 'images/food_items/beverages.png', 
      'text': 'Beverages',
      'route': MyRoutes.beveragesRoute
      }
    ];

  @override
  Widget build(BuildContext context) {

    return  GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: _categoryCardMapList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.011),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, _categoryCardMapList[index]['route']);
              },
              child: Card(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.04),
                  side: BorderSide(color: MyTheme.iconColor)
                  ),
                      
              child: (
                GridTile(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.044),
                      child: Image.asset(_categoryCardMapList[index]['image']!)
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.006),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6)
                        ),
                        child: Text(_categoryCardMapList[index]['text']!, 
                          style: TextStyle(color: MyTheme.cardColor,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              )
                      ),
                    ),
            ),
      );
    },
    );
  }
}