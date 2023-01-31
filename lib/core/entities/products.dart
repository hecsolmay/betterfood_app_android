class Product {
  final int id;
  final String name;
  final String description;
  final String urlImg;
  final double price;
  List<String>? ingredents;
  List<String>? remove;
  List<String>? extra;
  double? ofert;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.urlImg,
      required this.price,
      this.ingredents,
      this.remove,
      this.extra,
      this.ofert = 0});
}
