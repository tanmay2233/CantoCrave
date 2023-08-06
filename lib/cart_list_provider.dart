import 'package:flutter/cupertino.dart';

import 'cart_model.dart';

class CartListProvider extends ChangeNotifier{

  List<CartModel> cartList = [];

  double cartTotal = 0;

  void addToCart(String itemName, double itemPrice, int quantity) {
    bool itemAlreadyInCart = false;

    for (var item in cartList) {
      if (item.name == itemName) {
        item.quantity++;
        cartTotal += item.price;
        itemAlreadyInCart = true;
        break;
      }
    }

    if (!itemAlreadyInCart) {
      cartList.add(CartModel(itemName, itemPrice, 1));
      cartTotal += itemPrice;
    }
    notifyListeners();
  }


  void removeItem(String itemName) {
    bool itemAlreadyInCart = false;

    for (var item in cartList) {
      if (item.name == itemName) {
        item.quantity--;

        if (item.quantity == 0) {
          cartList.remove(item);
        }

        cartTotal -= item.price;
        itemAlreadyInCart = true;
        break;
      }
    }
    notifyListeners();
  }

  double getCartTotal() {
    return cartTotal;
  }

  int getCartSize() {
    return cartList.length;
  }

  int getItemQuantity(String itemName) {
    for (var item in cartList) {
      if (item.name == itemName) {
        return item.quantity;
      }
    }
    return 0;
  }


}