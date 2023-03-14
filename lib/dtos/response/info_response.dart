// To parse this JSON data, do
//
//     final infoResponseData = infoResponseDataFromJson(jsonString);

import 'dart:convert';

InfoResponseData infoResponseDataFromJson(String str) =>
    InfoResponseData.fromJson(json.decode(str));

String infoResponseDataToJson(InfoResponseData data) =>
    json.encode(data.toJson());

class InfoResponseData {
  InfoResponseData({
    this.limit,
    this.currentPage,
    this.nextPage,
    this.prevPage,
    this.next,
    this.prev,
    this.totalPages,
    this.items,
  });

  int? limit;
  int? currentPage;
  dynamic nextPage;
  dynamic prevPage;
  bool? next;
  bool? prev;
  int? totalPages;
  int? items;

  factory InfoResponseData.fromJson(Map<String, dynamic> json) =>
      InfoResponseData(
        limit: json["limit"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        next: json["next"],
        prev: json["prev"],
        totalPages: json["totalPages"],
        items: json["items"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "prevPage": prevPage,
        "next": next,
        "prev": prev,
        "totalPages": totalPages,
        "items": items,
      };
}
