// To parse this JSON data, do
//
//     final categoryResponseDto = categoryResponseDtoFromJson(jsonString);

import 'dart:convert';

CategoryResponseDto categoryResponseDtoFromJson(String str) => CategoryResponseDto.fromJson(json.decode(str));

String categoryResponseDtoToJson(CategoryResponseDto data) => json.encode(data.toJson());

class CategoryResponseDto {
    CategoryResponseDto({
        required this.name,
        required this.imgUrl,
        required this.id,
    });

    final String name;
    final String imgUrl;
    final String id;

     factory CategoryResponseDto.fromMap(Map<String, dynamic> json) => CategoryResponseDto(
        name: json["name"],
        imgUrl: json["imgURL"],
        id: json["id"],
    );

    factory CategoryResponseDto.fromJson(Map<String, dynamic> json) => CategoryResponseDto(
        name: json["name"],
        imgUrl: json["imgURL"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "imgURL": imgUrl,
        "id": id,
    };
}
