// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  final String name, image;
  bool isVeg = false;
  final double price;
  int quantity;

  CartModel(
    this.name,
    this.price,
    this.quantity,
    this.image,
    this.isVeg
  );
}
