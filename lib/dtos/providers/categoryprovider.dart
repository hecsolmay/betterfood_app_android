import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:betterfood_app_android/dtos/response/categoryresponse.dart';
class CategoryProvider extends ChangeNotifier{
  bool isLoading = true;
  final logger = Logger();

  List<CategoryResponseDto>? _categories;

  List<CategoryResponseDto>? get categories => _categories;

   Future fetchCategory() async {
    final response = await http
      .get(Uri.parse('https://betterfood-api.up.railway.app/api/m/category'));
     
      
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final List<dynamic>results = json['results'];
    print('${results}');
    _categories = results.map((e) => CategoryResponseDto.fromMap(e)).toList();
    
    isLoading = false;

    notifyListeners();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  

  
}
}