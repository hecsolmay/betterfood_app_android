// To parse this JSON data, do
//
//     final helpRequest = helpRequestFromJson(jsonString);

import 'dart:convert';

HelpRequest helpRequestFromJson(String str) =>
    HelpRequest.fromJson(json.decode(str));

String helpRequestToJson(HelpRequest data) => json.encode(data.toJson());

class HelpRequest {
  HelpRequest({
    required this.waiterId,
    required this.idTable,
  });

  String waiterId;
  String idTable;

  factory HelpRequest.fromJson(Map<String, dynamic> json) => HelpRequest(
        waiterId: json["waiterId"],
        idTable: json["idTable"],
      );

  Map<String, dynamic> toJson() => {
        "waiterId": waiterId,
        "idTable": idTable,
      };
}
