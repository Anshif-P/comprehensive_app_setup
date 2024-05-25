class ProductModel {
  dynamic id;
  String title;
  String description;
  String category;
  dynamic price;
  dynamic image;
  dynamic rating;
  ProductModel(
      {required this.id,
      required this.category,
      required this.description,
      required this.image,
      required this.price,
      required this.rating,
      required this.title});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        category: json['category'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
        rating: json['rating']['rate'],
        title: json['title']);
  }
}
