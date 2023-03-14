// To parse this JSON data, do
//
//     final waiterResponseDto = waiterResponseDtoFromJson(jsonString);

import 'dart:convert';

WaiterResponseDto waiterResponseDtoFromJson(String str) =>
    WaiterResponseDto.fromJson(json.decode(str));

String waiterResponseDtoToJson(WaiterResponseDto data) =>
    json.encode(data.toJson());

class WaiterResponseDto {
  WaiterResponseDto({
    required this.name,
    required this.lastName,
    required this.id,
  });

  final String name;
  final String lastName;
  final String id;

  factory WaiterResponseDto.fromJson(Map<String, dynamic> json) =>
      WaiterResponseDto(
        name: json["name"],
        lastName: json["lastName"],
        id: json["id"],
      );

  factory WaiterResponseDto.fromMap(Map<String, dynamic> json) =>
      WaiterResponseDto(
        name: json["name"],
        lastName: json["lastName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "id": id,
      };
}
