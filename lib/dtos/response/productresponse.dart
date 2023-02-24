// To parse this JSON data, do
//
//     final productResponseDto = productResponseDtoFromJson(jsonString);

import 'dart:convert';

ProductResponseDto productResponseDtoFromJson(String str) =>
    ProductResponseDto.fromJson(json.decode(str));

String productResponseDtoToJson(ProductResponseDto data) =>
    json.encode(data.toJson());

class ProductResponseDto {
  ProductResponseDto({
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.description,
    required this.id,
  });

  final String name;
  final String imgUrl;
  final int price;
  final String description;
  final String id;

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      ProductResponseDto(
        name: json["name"],
        imgUrl: json["imgURL"],
        price: json["price"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imgURL": imgUrl,
        "price": price,
        "description": description,
        "id": id,
      };
}
