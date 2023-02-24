import 'dart:convert';
import 'dart:math';

import 'package:betterfood_app_android/common/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:betterfood_app_android/dtos/response/categoryresponse.dart';

class categoryProvider extends ChangeNotifier {
  bool isLoading = true;
  final logger = Logger();

  List<CategoryResponseDto>? _categories;

  List<CategoryResponseDto>? get categories => _categories;

  Future fetchCategory() async {
    try {
      final response =
          await http.get(Uri.parse('${Globals.apiURL}/api/m/category'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json['results'];
        _categories =
            results.map((e) => CategoryResponseDto.fromMap(e)).toList();
        print(results);
        isLoading = false;

        notifyListeners();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e);
    }
  }
}
