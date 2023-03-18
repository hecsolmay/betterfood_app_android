import 'package:betterfood_app_android/dtos/request/help_request.dart';
import 'package:betterfood_app_android/dtos/response/mesa_response.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:betterfood_app_android/common/globals.dart';
import 'package:betterfood_app_android/dtos/response/mesero_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class RegisterProvider extends ChangeNotifier {
  bool _found = false;
  bool get found => _found;
  final logger = Logger();
  WaiterResponseDto? _waiter;

  bool _foundTable = false;
  bool get foundTable => _foundTable;
  bool _notificationSend = false;
  bool get notificationSend => _notificationSend;

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
        _foundTable = true;
        notifyListeners();
      } else {
        throw Exception('Failed to load table');
      }
    } catch (e) {
      logger.d(e);
    }
  }

  WaiterResponseDto? get waiter => _waiter;

  Future<void> getByIdWaiter(String id) async {
    try {
      final url = "${Globals.apiURL}/api/m/waiter/$id";
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _waiter = WaiterResponseDto.fromJson(json["results"]);
        _found = true;
        notifyListeners();
      } else {
        throw Exception('Failed to load waiter');
      }
    } catch (e) {
      logger.d(e);
    }
  }

  Future<void> postHelp(HelpRequest request) async {
    try {
      _notificationSend = false;
      final jsonBody = helpRequestToJson(request);
      final url = "${Globals.apiURL}/api/notification/hel";
      final response =
          await http.post(Uri.parse(url), body: jsonBody, headers: {
        "Content-Type": "application/json",
      });
      logger.d(response.body);

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        logger.d(json);
        _notificationSend = true;
      } else {
        throw Exception('Failed to load waiter');
      }
    } catch (e) {
      logger.d(e);
    }
    notifyListeners();
  }
}
