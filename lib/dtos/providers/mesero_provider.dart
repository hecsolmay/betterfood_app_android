import 'dart:convert';
import 'package:betterfood_app_android/common/globals.dart';
import 'package:betterfood_app_android/dtos/response/mesero_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class WaiterProvider extends ChangeNotifier {

  WaiterResponseDto? _waiter = null;

  WaiterResponseDto? get waiter => _waiter;

  Future<void> getByIdWaiter(String id) async {
    try {
      
      final url = "${Globals.apiURL}/api/m/waiter/$id";
      final response = await http.get(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _waiter = WaiterResponseDto.fromJson(json["results"]);
        notifyListeners();
      } else {
        throw Exception('Failed to load waiter');
      }
    } catch (e) {
      print(e);
    } 
  }
}

