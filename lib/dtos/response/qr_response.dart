// To parse this JSON data, do
//
//     final qrResponse = qrResponseFromJson(jsonString);

import 'dart:convert';

QrResponse qrResponseFromJson(String str) =>
    QrResponse.fromJson(json.decode(str));

class QrResponse {
  QrResponse({
    required this.waiterId,
    required this.tableId,
  });

  String waiterId;
  String tableId;

  factory QrResponse.fromJson(Map<String, dynamic> json) => QrResponse(
        waiterId: json["waiterId"],
        tableId: json["tableId"],
      );
}
