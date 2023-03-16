import 'dart:convert';

import 'package:betterfood_app_android/common/globals.dart';
import 'package:betterfood_app_android/core/entities/products.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class OrdersProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  final logger = Logger();

  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
    for (var i = 0; i < products.length; i++) {
      var element = products[i];
      logger.d(element.product.name);
      logger.d(element.quantity);
    }
    notifyListeners();
  }

  void removeProduct(int index) {
    if (index >= 0 && index < products.length) {
      products.removeAt(index);
      notifyListeners();
    }
  }
}

class Product {
  Product({
    required this.product,
    required this.extras,
    required this.remove,
    required this.quantity,
  });

  ProductResponseDto product;
  List<String> extras;
  List<String> remove;
  int quantity;
}
