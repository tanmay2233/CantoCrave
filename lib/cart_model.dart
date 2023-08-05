class CartModel {
  final String name;
  final double price;
  int quantity;
  static List<CartModel> _cartItems = [];
  static double _cartTotal = 0;

  CartModel(this.name, this.price, this.quantity);

  static void addToCart(String itemName, double itemPrice, int quantity) {
    bool itemAlreadyInCart = false;

    for (var item in _cartItems) {
      if (item.name == itemName) {
        item.quantity++;
        _cartTotal += item.price;
        itemAlreadyInCart = true;
        break;
      }
    }

    if (!itemAlreadyInCart) {
      _cartItems.add(CartModel(itemName, itemPrice, 1));
      _cartTotal += itemPrice;
    }
  }

  static double getCartTotal() {
    return _cartTotal;
  }

  static int getCartSize() {
    return _cartItems.length;
  }

  static int getItemQuantity(String itemName) {
    for (var item in _cartItems) {
      if (item.name == itemName) {
        return item.quantity;
      }
    }
    return 0;
  }

  static void removeItem(String itemName) {
    bool itemAlreadyInCart = false;

    for (var item in _cartItems) {
      if (item.name == itemName) {
        item.quantity--;

        if (item.quantity == 0) {
          _cartItems.remove(item);
        }

        _cartTotal -= item.price;
        itemAlreadyInCart = true;
        break;
      }
    }
  }
}
