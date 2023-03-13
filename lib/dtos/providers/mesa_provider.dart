import 'dart:convert';
import 'package:betterfood_app_android/common/globals.dart';
import 'package:betterfood_app_android/dtos/response/mesa_response.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class TableProvider extends ChangeNotifier {
  bool _found = false;
  bool get found => _found;
  final logger = Logger();

  TableResponseDto? _table;

  TableResponseDto? get table => _table;

  Future<void> getByIdTable(String id) async {
    try {
      final url = "${Globals.apiURL}/api/m/table/$id";
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _table = TableResponseDto.fromJson(json["results"]);
        _found = true;
        notifyListeners();
      } else {
        throw Exception('Failed to load table');
      }
    } catch (e) {
      logger.d(e);
    }
  }
}
