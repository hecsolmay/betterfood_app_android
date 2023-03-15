import 'dart:convert';

import 'package:betterfood_app_android/common/globals.dart';
import 'package:betterfood_app_android/dtos/response/productdetailresponse.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/dtos/response/info_response.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingNextPage = false;
  bool hasError = false;
  final logger = Logger();

  List<ProductResponseDto> _products = [];
  InfoResponseData? info;
  List<ProductResponseDto> _productsCategory = [];
  InfoResponseData? infoCategory;
  List<ProductResponseDto> _productsSearched = [];
  InfoResponseData? infoSearched;

  ProductDetailResponseDto? _productdetail;
  ProductDetailResponseDto? get productdetail => _productdetail;

  List<ProductResponseDto> get products => _products;
  List<ProductResponseDto> get productsCategory => _productsCategory;
  List<ProductResponseDto>? get productsSearched => _productsSearched;

  Future<dynamic> getAll() async {
    try {
      isLoading = true;
      final url = "${Globals.apiURL}/api/m/product/";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        _products = results.map((e) => ProductResponseDto.fromJson(e)).toList();
        final dynamic jsonInfo = json["info"];
        info = InfoResponseData.fromJson(jsonInfo);
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

  Future<dynamic> getPaginate(int nextPage) async {
    isLoadingNextPage = true;
    hasError = false;
    logger.d(nextPage);
    notifyListeners();
    final url = '${Globals.apiURL}/api/m/product?page=$nextPage';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json['results'];
        final newProducts =
            results.map((e) => ProductResponseDto.fromJson(e)).toList();
        _products.addAll(newProducts);
        final dynamic jsonInfo = json['info'];
        info = InfoResponseData.fromJson(jsonInfo);
        logger.d(results);
      } else {
        hasError = true;
      }
    } catch (e) {
      logger.e(e);
      hasError = true;
    }
    isLoadingNextPage = false;
    notifyListeners();
  }

  Future<dynamic> refreshProducts() async {
    try {
      isLoading = true;
      hasError = false;
      notifyListeners();
      final url = "${Globals.apiURL}/api/m/product/";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        _products = results.map((e) => ProductResponseDto.fromJson(e)).toList();
        final dynamic jsonInfo = json["info"];
        info = InfoResponseData.fromJson(jsonInfo);

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

  Future<dynamic> initGetAllByCategory(String id) async {
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
        final dynamic jsonInfo = json["info"];
        infoCategory = InfoResponseData.fromJson(jsonInfo);
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
      hasError = false;
      notifyListeners();
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
        final dynamic jsonInfo = json["info"];
        infoCategory = InfoResponseData.fromJson(jsonInfo);

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

  Future<dynamic> getProductsCategoryPaginate(String id, int nextPage) async {
    try {
      isLoadingNextPage = true;
      hasError = false;
      notifyListeners();
      logger.d(id);
      final url =
          "${Globals.apiURL}/api/m/category/$id/products?page=$nextPage";
      logger.d(url);
      final response = await http.get(Uri.parse(url));
      logger.d(response.statusCode);
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        final newProducts =
            results.map((e) => ProductResponseDto.fromJson(e)).toList();
        final dynamic jsonInfo = json["info"];
        _productsCategory.addAll(newProducts);
        infoCategory = InfoResponseData.fromJson(jsonInfo);

        logger.d(results);
      } else {
        logger.e("Failed to load Productss");
        hasError = true;
      }
    } catch (e) {
      hasError = true;
      logger.e(e);
    }

    isLoadingNextPage = false;
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

  Future<dynamic> getSearch(String query) async {
    try {
      isLoading = true;
      notifyListeners();
      final url = "${Globals.apiURL}/api/m/product?q=$query";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        _productsSearched =
            results.map((e) => ProductResponseDto.fromJson(e)).toList();

        final dynamic jsonInfo = json["info"];
        infoSearched = InfoResponseData.fromJson(jsonInfo);

        logger.d('Busqueda Ok');
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
  }
}
