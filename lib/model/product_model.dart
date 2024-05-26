class ProductModel {
  dynamic id;
  String title;
  String category;
  dynamic price;
  dynamic image;
  String? localImagePath;

  ProductModel({
    required this.id,
    required this.category,
    required this.image,
    required this.price,
    required this.title,
    this.localImagePath,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        category: json['category'],
        image: json['image'],
        price: json['price'],
        title: json['title'],
        localImagePath: json['localImagePath']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'image': image,
      'price': price,
      'title': title,
      'localImagePath': localImagePath,
    };
  }
}
