// // To parse this JSON data, do
// //
// //     final productResponseDto = productResponseDtoFromJson(jsonString);

// import 'dart:convert';

// ProductResponseDto productResponseDtoFromJson(String str) =>
//     ProductResponseDto.fromJson(json.decode(str));

// String productResponseDtoToJson(ProductResponseDto data) =>
//     json.encode(data.toJson());

// class ProductResponseDto {
//   ProductResponseDto({
//     required this.name,
//     required this.imgUrl,
//     required this.price,
//     required this.description,
//     required this.id,
//   });

//   final String name;
//   final String imgUrl;
//   final int price;
//   final String description;
//   final String id;

//   factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
//       ProductResponseDto(
//         name: json["name"],
//         imgUrl: json["imgURL"],
//         price: json["price"],
//         description: json["description"],
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "imgURL": imgUrl,
//         "price": price,
//         "description": description,
//         "id": id,
//       };
// }

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
    required this.ingredents,
    required this.id,
  });

  String name;
  String imgUrl;
  int price;
  String description;
  List<Ingredent> ingredents;
  String id;

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      ProductResponseDto(
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

  String id;
  String name;
  bool required;
  int extraPrice;

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
