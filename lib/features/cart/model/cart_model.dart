class CartModel {

  final String id;
  final String name;
  final String image;
  final num price;
  final num quantity;
  final num totalPrice;

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
    );
  }

}
