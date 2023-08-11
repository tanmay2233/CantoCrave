// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_firebase/cart_model.dart';

class MyOrders {
  static List<List<CartModel>> _MyOrdersList = [];

  static void addOrders(List<CartModel> orderedItems){
    _MyOrdersList.add(orderedItems);
  }

  static List<List<CartModel>> getMyOrderList(){ 
    return _MyOrdersList;
  }

  static void addToMyOrders(List<CartModel> orderedItems){
    _MyOrdersList.add(orderedItems);
  } 

  static double getOrderTotal(int index){
    double total = 0;
    for(var cost in _MyOrdersList[index]){
      total += cost.price*cost.quantity;
    }
    return total;
  }
}