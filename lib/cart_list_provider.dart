// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'cart_model.dart';

class CartListProvider extends ChangeNotifier{

  List<CartModel> cartList = [];

  double cartTotal = 0;

  Future<int> getItemQuantity(String itemName) async {
    final cartRef = FirebaseFirestore.instance.collection('cart');

    final cartSnapshot = await cartRef.get();
    if (cartSnapshot.size > 0) {
      for (var cartDoc in cartSnapshot.docs) {
        final cartData = cartDoc.data();
        final cartItems =
            List<Map<String, dynamic>>.from(cartData['items'] ?? []);

        final existingCartItem = cartItems.firstWhereOrNull(
          (item) => item['name'] == itemName,
        );

        if (existingCartItem != null) {
          notifyListeners();
          return existingCartItem['quantity']; // Return the quantity of the item
        } 
      }
      notifyListeners();
    }
    notifyListeners();
    return 0; // Return 0 if item not found in the cart
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(CartModel model) async {
    final user = _auth.currentUser;
    if (user != null) {
      final cartRef = _firestore.collection('cart').doc(user.uid);
      final cartItem = CartModel(model.name, model.price, 1, model.image, model.isVeg);

      final cartData = await cartRef.get();
      List<Map<String, dynamic>> cartItems = [];

      if (cartData.exists) {
        if (cartData.data()!.containsKey('items')) {
          cartItems = List<Map<String, dynamic>>.from(cartData.get('items'));
        }
      }

      final existingCartItem = cartItems.firstWhereOrNull(
        (item) => item['name'] == model.name
      );

      if (existingCartItem != null) {
        existingCartItem['quantity'] += 1;
      } else {
        cartItems.add(cartItem.toJson());
      }

      await cartRef.set({'items': cartItems}, SetOptions(merge: true));
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> decreaseQuantity(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      final cartRef = _firestore.collection('cart').doc(user.uid);

      // Get the existing cart items
      final cartData = await cartRef.get();
      final cartItems =
        List<Map<String, dynamic>>.from(cartData.get('items') ?? []);

      final existingCartItemIndex =
        cartItems.indexWhere((item) => item['name'] == name);

      if (existingCartItemIndex != -1) {
        final existingCartItem = cartItems[existingCartItemIndex];
        final currentQuantity = existingCartItem['quantity'];

        if (currentQuantity > 1) {
          cartItems[existingCartItemIndex]['quantity'] = currentQuantity - 1;
        } else {
          cartItems.removeAt(existingCartItemIndex);
        }

        await cartRef.set({'items': cartItems}, SetOptions(merge: true));
        notifyListeners();
      }
    }
  }


  Future<bool> checkCartItem(String itemName) async {
    final cartRef = FirebaseFirestore.instance.collection('cart');

    final cartSnapshot = await cartRef.get();
    if (cartSnapshot.size > 0) {
      for (var cartDoc in cartSnapshot.docs) {
        final cartData = cartDoc.data();
        final cartItems =
            List<Map<String, dynamic>>.from(cartData['items'] ?? []);

        final existingCartItem = cartItems.firstWhereOrNull(
          (item) => item['name'] == itemName,
        );

        if (existingCartItem != null) {
          return true;
        } 
        else {
          return false;
        }
      }
    } 
    else {
      notifyListeners();
      return false;
    }
    notifyListeners();
    return false;
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> cartItems = [];
    final user = auth.currentUser;
    if (user != null) {
      final cartRef = firestore.collection('cart').doc(user.uid);
      final cartData = await cartRef.get();
      if(cartData.exists){

      cartItems = List<Map<String, dynamic>>.from(cartData.get('items') ?? []);
      }
      notifyListeners();
      return cartItems;
    }
    return [];
  }

  Future<double> getCartTotal() async {
    double total = 0;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final user = auth.currentUser;

    if (user != null) {
      final cartRef = firestore.collection('cart').doc(user.uid);
      final cartData = await cartRef.get();

      if (cartData.exists) {
        final cartItems =
            List<Map<String, dynamic>>.from(cartData.get('items') ?? []);

        for (var item in cartItems) {
          total += (item['price'] * item['quantity']).toDouble();
        }

        notifyListeners();
        return total;
      }
    }
    return 0;
  }



  Future<void> uploadCartItems() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = auth.currentUser;

  if (user != null) {
    final cartRef = firestore.collection('cart').doc(user.uid);
    final cartData = await cartRef.get();

    final userDocRef = firestore.collection('orders').doc(user.uid);
    final orderHistoryCollectionRef = userDocRef.collection('orderHistory');

    // Generate a random 6-digit order ID
    final orderId =
      (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();

    // Create a new order document with order date
    final orderDocRef = orderHistoryCollectionRef.doc(orderId);
    await orderDocRef.set({
      'orderDate': FieldValue.serverTimestamp(),
      'items': cartData.exists ? (cartData.data()!['items'] as List<dynamic>) : [],

    });

    await cartRef.delete();
  }
}

}