import 'dart:convert';

import 'package:betterfood_app_android/common/globals.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class OrdersProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  final logger = Logger();

  List products = [];

  void add() {}

  void remove() {}
}
