import 'dart:convert';
import 'package:betterfood_app_android/common/globals.dart';
import 'package:betterfood_app_android/dtos/response/mesa_response.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class TableProvider extends ChangeNotifier {

  TableResponseDto? _table = null;

  TableResponseDto? get table => _table;

  Future<void> getByIdTable(String id) async {
    try {
      final url  = "${Globals.apiURL}/api/m/table/$id";
      final response = await http.get(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _table = TableResponseDto.fromJson(json["results"]);
        notifyListeners();
      } else {
        throw Exception('Failed to load table');
      }
    } catch (e) {
      print(e);
    } 
  }
}
