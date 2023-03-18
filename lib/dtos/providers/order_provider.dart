import 'dart:convert';

import 'package:betterfood_app_android/common/globals.dart';
import 'package:betterfood_app_android/core/entities/products.dart';
import 'package:betterfood_app_android/dtos/request/order_request.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class OrdersProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  bool orderSend = false;
  final logger = Logger();

  List<Product> products = [];

  Future<void> postOrder(List<ProductOrder> productsOrder) async {
    try {
      hasError = false;
      orderSend = false;
      final orderRequest = OrderRequestDto(
          products: productsOrder,
          waiterId: '63f804a8757fa73689a81958',
          tableId: '63f8df91757fa73689a81a98');
      final jsonBody = orderRequestDtoToJson(orderRequest);
      final url = "${Globals.apiURL}/api/order";
      final response =
          await http.post(Uri.parse(url), body: jsonBody, headers: {
        "Content-Type": "application/json",
      });
      logger.d(response.body);

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        logger.d(json);
        orderSend = true;
      } else {
        hasError = true;
        throw Exception('Failed to load Order');
      }
    } catch (e) {
      logger.d(e);
      hasError = true;
    }
    notifyListeners();
  }

  void addProduct(Product product) {
    int index = products.indexWhere((element) {
      bool found = true;
      final originalExtras = element.extras;
      final originalRemove = element.remove;
      final incomingExtras = product.extras;
      final incomingRemove = product.remove;
      if (element.product.id != product.product.id) return false;

      logger.d(originalExtras);
      logger.d(incomingExtras);
      if (originalExtras.length != incomingExtras.length) return false;
      if (originalRemove.length != incomingRemove.length) return false;
      logger.d("Ya entro a la funcion");

      for (var i = 0; i < originalExtras.length; i++) {
        if (!incomingExtras.contains(originalExtras[i])) {
          found = false;
        }
      }
      for (var i = 0; i < originalRemove.length; i++) {
        if (!incomingRemove.contains(originalRemove[i])) {
          found = false;
        }
      }
      return found;
    });

    if (index != -1) {
      logger.d("Se encontro el producto");
      products[index].quantity += product.quantity;
    } else {
      products.add(product);
    }

    notifyListeners();
  }

  void removeAll() {
    products = [];
    notifyListeners();
  }

  void removeProduct(int index) {
    if (index >= 0 && index < products.length) {
      products.removeAt(index);
      notifyListeners();
    }
  }

  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < products.length) {
      products[index].quantity = newQuantity;
      notifyListeners();
    }
  }
}

class Product {
  Product(
      {required this.product,
      required this.extras,
      required this.remove,
      required this.quantity,
      required this.price});

  ProductResponseDto product;
  List<String> extras;
  List<String> remove;
  int quantity;
  int price;
}
