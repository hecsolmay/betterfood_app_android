import 'package:betterfood_app_android/core/entities.dart';

class ProductRepository {
  static List<Product> getProducts() => List.generate(
        20,
        (i) => Product(
          id: i + 1,
          name: "Product $i",
          price: 5.0 * i,
          ingredents: ["carne", "pastor", "Tortilla de Maíz"],
          remove: ["cebolla", "tomate", "pepino"],
          extra: ["Guacamole", "Chile"],
          urlImg:
              "https://cdn.pixabay.com/photo/2019/07/21/01/36/tacos-al-pastor-4351813_1280.jpg",
          description:
              "Nostrud cupidatat non proident deserunt sint enim dolor mollit nisi Lorem cupidatat elit. Ea magna aliqua in nisi veniam ut aliquip veniam elit in. Ex laborum eiusmod nulla velit officia reprehenderit aliquip non. Qui dolore quis incididunt Lorem. Amet est ea nostrud mollit exercitation id dolore in irure Lorem cillum tempor.",
        ),
      );
}
