class ProductModel {
  final int id;
  final String name;
  final double price;
  final String image; // Properti baru: image

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  // Fungsi toMap()
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
    };
  }

  // Factory constructor fromMap()
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      image: map['image'] as String,
    );
  }
}