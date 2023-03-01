// To parse this JSON data, do
//
//     final productDetailResponseDto = productDetailResponseDtoFromJson(jsonString);

import 'dart:convert';

ProductDetailResponseDto productDetailResponseDtoFromJson(String str) =>
    ProductDetailResponseDto.fromJson(json.decode(str));

String productDetailResponseDtoToJson(ProductDetailResponseDto data) =>
    json.encode(data.toJson());

class ProductDetailResponseDto {
  ProductDetailResponseDto({
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.description,
    required this.ingredents,
    required this.id,
  });

  final String name;
  final String imgUrl;
  final int price;
  final String description;
  final List<Ingredent> ingredents;
  final String id;

  factory ProductDetailResponseDto.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponseDto(
        name: json["name"],
        imgUrl: json["imgURL"],
        price: json["price"],
        description: json["description"],
        ingredents: List<Ingredent>.from(
            json["ingredents"].map((x) => Ingredent.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imgURL": imgUrl,
        "price": price,
        "description": description,
        "ingredents": List<dynamic>.from(ingredents.map((x) => x.toJson())),
        "id": id,
      };
}

class Ingredent {
  Ingredent({
    required this.id,
    required this.name,
    required this.required,
    required this.extraPrice,
  });

  final String id;
  final String name;
  final bool required;
  final int extraPrice;

  factory Ingredent.fromJson(Map<String, dynamic> json) => Ingredent(
        id: json["id"],
        name: json["name"],
        required: json["required"],
        extraPrice: json["extraPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "required": required,
        "extraPrice": extraPrice,
      };
}
