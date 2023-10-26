// ignore_for_file: public_member_api_docs, sort_constructors_first

class CartModel {
  final String name, image;
  bool isVeg = false;
  final double price;
  int quantity;
  int id;
  bool isFavourite = false;

  CartModel(
    this.name,
    this.price,
    this.quantity,
    this.image,
    this.isVeg,
    this.id
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'isVeg': isVeg,
      'itemId': id
    };
  }
}