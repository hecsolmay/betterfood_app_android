import 'package:flutter/material.dart';

class CustomIngredentsProvider extends ChangeNotifier {
  List<String> _extras = [];
  List<String> _remove = [];

  List<String> get extras => _extras;
  List<String> get remove => _remove;

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
