// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  OrderResponse({
    required this.waiterId,
    required this.status,
    required this.tableId,
    required this.total,
    required this.totalQuantity,
    required this.orderNumber,
    required this.id,
  });

  String waiterId;
  String status;
  String tableId;
  int total;
  int totalQuantity;
  String orderNumber;
  String id;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        waiterId: json["waiterId"],
        status: json["status"],
        tableId: json["tableId"],
        total: json["total"],
        totalQuantity: json["totalQuantity"],
        orderNumber: json["orderNumber"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "waiterId": waiterId,
        "status": status,
        "tableId": tableId,
        "total": total,
        "totalQuantity": totalQuantity,
        "orderNumber": orderNumber,
        "id": id,
      };
}
