// To parse this JSON data, do
//
//     final tableResponseDto = tableResponseDtoFromJson(jsonString);

// To parse this JSON data, do
//
//     final tableResponseDto = tableResponseDtoFromJson(jsonString);

import 'dart:convert';

TableResponseDto tableResponseDtoFromJson(String str) =>
    TableResponseDto.fromJson(json.decode(str));

String tableResponseDtoToJson(TableResponseDto data) =>
    json.encode(data.toJson());

class TableResponseDto {
  TableResponseDto({
    required this.numMesa,
    required this.capacity,
    required this.id,
  });

  final int numMesa;
  final int capacity;
  final String id;

  factory TableResponseDto.fromJson(Map<String, dynamic> json) =>
      TableResponseDto(
        numMesa: json["numMesa"],
        capacity: json["capacity"],
        id: json["id"],
      );

  factory TableResponseDto.fromMap(Map<String, dynamic> json) =>
      TableResponseDto(
        numMesa: json["numMesa"],
        capacity: json["capacity"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "numMesa": numMesa,
        "capacity": capacity,
        "id": id,
      };
}
