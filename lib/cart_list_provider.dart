// ignore_for_file: unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_model.dart';

class CartListProvider extends ChangeNotifier {
  List<CartModel> cartList = [];
  double cartTotal = 0;

  Future<int> getQuantity(String itemName) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Menu_Items').get();

    for (var docSnapshot in querySnapshot.docs) {
      final data = docSnapshot.data();
      if (data != null && data['name'] == itemName) {
        return data['quantity'] ?? 0;
      }
    }
    return 0;
  }

  Future<int> getItemQuantityFromCart(String itemName) async {
    final user = _auth.currentUser;

    if (user != null) {
      final cartRef =
          FirebaseFirestore.instance.collection('cart').doc(user.uid);
      final cartDocSnapshot = await cartRef.get();

      if (cartDocSnapshot.exists) {
        final cartData = cartDocSnapshot.data();
        final cartItems =
            List<Map<String, dynamic>>.from(cartData?['items'] ?? []);

        final existingCartItem = cartItems.firstWhereOrNull(
          (item) => item['name'] == itemName,
        );

        if (existingCartItem != null) {
          return existingCartItem[
              'quantity']; 
        }
      }
    }

    return 0; 
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(CartModel model) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final cartRef = _firestore.collection('cart').doc(user.uid);
        final cartItem =
            CartModel(model.name, model.price, 1, model.image, model.isVeg);

        final cartData = await cartRef.get();
        List<Map<String, dynamic>> cartItems = [];

        if (cartData.exists) {
          if (cartData.data()!.containsKey('items')) {
            cartItems = List<Map<String, dynamic>>.from(cartData.get('items'));
          }
        }

        final existingCartItemIndex =
            cartItems.indexWhere((item) => item['name'] == model.name);

        if (existingCartItemIndex != -1) {
          cartItems[existingCartItemIndex]['quantity'] += 1;
        } else {
          cartItems.add(cartItem.toJson());
        }

        await cartRef.set({'items': cartItems}, SetOptions(merge: true));

        final updatedCartData = await cartRef.get();
        final updatedCartItems =
            updatedCartData.data()?['items'] as List<dynamic>;

        notifyListeners(); 
      }
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }


  Future<void> decreaseQuantity(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      final cartRef = _firestore.collection('cart').doc(user.uid);

      final cartData = await cartRef.get();

      // Check if the cart document exists
      if (cartData.exists) {
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

          // Update the 'items' field
          await cartRef.set({'items': cartItems}, SetOptions(merge: true));
          notifyListeners();
        }
      }
    }
  }


  Future<bool> checkCartItem(String itemName) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final cartRef =
            FirebaseFirestore.instance.collection('cart').doc(user.uid);
        final cartSnapshot = await cartRef.get();

        if (cartSnapshot.exists) {
          final cartData = cartSnapshot.data();
          final cartItems =
              List<Map<String, dynamic>>.from(cartData?['items'] ?? []);

          final existingCartItem = cartItems.firstWhereOrNull(
            (item) => item['name'] == itemName,
          );

          if (existingCartItem != null) {
            return true;
          }
        }
      }
    } catch (e) {
      print("Error checking cart item: $e");
    }

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
      if (cartData.exists) {
        cartItems =
            List<Map<String, dynamic>>.from(cartData.get('items') ?? []);
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

  Future<void> uploadCartItems(String orderId) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final user = auth.currentUser;

    if (user != null) {
      final cartRef = firestore.collection('cart').doc(user.uid);
      final cartData = await cartRef.get();

      final userDocRef = firestore.collection('orders').doc(user.uid);
      final orderHistoryCollectionRef = userDocRef.collection('orderHistory');

      final orderDocRef = orderHistoryCollectionRef.doc(orderId);
      await orderDocRef.set({
        'orderDate': FieldValue.serverTimestamp(),
        'items':
            cartData.exists ? (cartData.data()!['items'] as List<dynamic>) : [],
      });

      await cartRef.delete();
    }
  }

  Future<void> placeOrder(String orderId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var orderedItems = await getCartItems();
        final orderData = {
          'orderId': orderId,
          'username': user.displayName,
          'items': orderedItems,
          'orderDate': FieldValue.serverTimestamp()
        };
        await _firestore.collection('newOrders').add(orderData);
      }
    } catch (e) {
      print("Error placing order: $e");
    }
  }


  Future<bool> updateMenuItemsAfterOrder(BuildContext context) async {
    bool allItemsAvailbale = true;

    final cartSnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    final cartData = cartSnapshot.data();

    final menuSnapshot =
        await FirebaseFirestore.instance.collection('Menu_Items').get();
    final menuItems = menuSnapshot.docs;

    // Iterate through user's cart items
    if(cartData!=null && cartData['items']!= null){
      for (final cartItem in cartData['items']) {
      final cartItemName = cartItem['name'];
      final cartItemQuantity = cartItem['quantity'];

      final menuItem = menuItems.firstWhere(
        (item) => item['name'] == cartItemName,
      );
      final menuItemQuantity = menuItem['quantity'];

      // Reduce the menu item's quantity
      final updatedMenuItemQuantity = menuItemQuantity - cartItemQuantity;
      
      if (updatedMenuItemQuantity < 0) {
        var snackBar = SnackBar(
          content:
            Text("Desired Quantity of ${cartItem['name']} Not Available"),
          duration: const Duration(seconds: 3),
        );
        allItemsAvailbale = false;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
    }}
    if (allItemsAvailbale == true && (cartData!=null && cartData['items']!= null)) {
      for (final cartItem in cartData['items']) {
        final cartItemName = cartItem['name'];
        final cartItemQuantity = cartItem['quantity'];

        final menuItem = menuItems.firstWhere(
          (item) => item['name'] == cartItemName,
        );
        final menuItemQuantity = menuItem['quantity'];

        final updatedMenuItemQuantity = menuItemQuantity - cartItemQuantity;

        await FirebaseFirestore.instance
            .collection('Menu_Items')
            .doc(menuItem.id)
            .update({
          'quantity': updatedMenuItemQuantity,
        });
      }
      return true;
    }
    return false;
  }


  Future<void> placeOrderAndUploadItems(BuildContext context) async {
    var orderId =
      (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();

    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final user = auth.currentUser;

    if (user != null) {
      final cartRef = firestore.collection('cart').doc(user.uid);
      final cartData = await cartRef.get();
      if (cartData.exists) {
        final cartItems =
          List<Map<String, dynamic>>.from(cartData.get('items') ?? []);
        if(cartItems.length > 0){
          bool allItemsAvailbale = await updateMenuItemsAfterOrder(context);
          if(allItemsAvailbale){
            await placeOrder(orderId);
            await uploadCartItems(orderId);
          }
        }
      }
  }


  
  }
}