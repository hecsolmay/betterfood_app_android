import 'dart:convert';

import 'package:betterfood_app_android/common/globals.dart';
import 'package:betterfood_app_android/dtos/response/productdetailresponse.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  final logger = Logger();

  List<ProductResponseDto>? _products = [];
  List<ProductResponseDto>? _productsCategory = [];

  ProductDetailResponseDto? _productdetail;
  ProductDetailResponseDto? get productdetail => _productdetail;

  List<ProductResponseDto>? get products => _products;
  List<ProductResponseDto>? get productsCategory => _productsCategory;

  Future<dynamic> getAll() async {
    try {
      isLoading = true;
      final url = "${Globals.apiURL}/api/m/product/";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        _products = results.map((e) => ProductResponseDto.fromJson(e)).toList();

        logger.d(results);
      } else {
        logger.e("Failed to load Productss");
        hasError = true;
      }
    } catch (e) {
      hasError = true;
      logger.e(e);
    }

    isLoading = false;
    notifyListeners();

    return [];
  }

  Future<dynamic> getAllByCategory(String id) async {
    try {
      isLoading = true;
      logger.d(id);
      final url = "${Globals.apiURL}/api/m/category/$id/products";
      logger.d(url);
      final response = await http.get(Uri.parse(url));
      logger.d(response.statusCode);
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        _productsCategory =
            results.map((e) => ProductResponseDto.fromJson(e)).toList();

        logger.d(results);
      } else {
        logger.e("Failed to load Productss");
        hasError = true;
      }
    } catch (e) {
      hasError = true;
      logger.e(e);
    }

    isLoading = false;
    notifyListeners();

    return [];
  }

  Future<dynamic> getById(String id) async {
    try {
      isLoading = true;
      final url = "${Globals.apiURL}/api/m/product/$id";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final dynamic results = json["results"];
        _productdetail = ProductDetailResponseDto.fromJson(results);

        logger.d(response.body);
      } else {
        logger.e("Failed to load Product");
        hasError = true;
      }
    } catch (e) {
      logger.e(e);
      hasError = true;
    }
    isLoading = false;
    notifyListeners();
    return [];
  }
}
