class Product {
  final int id;
  String title;
  double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      imageUrl: json['image'],
    );
  }
}
