import 'dart:convert';

import 'package:betterfood_app_android/dtos/response/productdetailresponse.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomIngredentsProvider extends ChangeNotifier {
  List<String> _extras = [];
  List<String> _remove = [];
  final List<Ingredent> _ingredentsremove = [];

  List<Ingredent>? get ingredentsRemove => _ingredentsremove;

  void addIngredentsRemove(Iterable<Ingredent> ingredents) {
    _ingredentsremove.addAll(ingredents);
  }

  void deleteIngredentRemove(String id) {
    int index = _ingredentsremove.indexWhere((element) => element.id == id);

    if (index != -1) {
      _ingredentsremove.removeAt(index);
    }

    notifyListeners();
  }

  void addExtra(String id) {
    _extras.add(id);
    notifyListeners();
  }

  void removeExtra(String id) {
    int index = _extras.indexOf(id);

    if (index != -1) {
      _extras.removeAt(index);
      notifyListeners();
    }
  }

  void resetState() {
    _extras = [];
    _remove = [];
  }

  bool extrasContains(String id) {
    return _extras.contains(id);
  }

  bool removeContains(String id) {
    return _remove.contains(id);
  }

  void addRemove(String id) {
    _remove.add(id);
    notifyListeners();
  }
}
