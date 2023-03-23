import 'package:betterfood_app_android/dtos/response/mesa_response.dart';
import 'package:betterfood_app_android/dtos/response/mesero_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedCache {
  Future<WaiterResponseDto?> getWaiterFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final waiterName = prefs.getString('waiter_name');
    final waiterLastName = prefs.getString('waiter_last_name');
    final waiterId = prefs.getString('waiter_id');
    if (waiterName != null && waiterLastName != null && waiterId != null) {
      return WaiterResponseDto(
        name: waiterName,
        lastName: waiterLastName,
        id: waiterId,
      );
    } else {
      return null;
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> saveWaiterToCache(WaiterResponseDto? waiter) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('waiter_name', waiter!.name);
    prefs.setString('waiter_last_name', waiter.lastName);
    prefs.setString('waiter_id', waiter.id);
  }

  Future<void> saveTableToCache(TableResponseDto? table) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('table_id', table!.id);
    prefs.setInt('table_num', table.numMesa);
    prefs.setInt('table_capacity', table.capacity);
  }

  Future<TableResponseDto?> getTableFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final tableId = prefs.getString('table_id');
    final tableNum = prefs.getInt('table_num');
    final tableCapacity = prefs.getInt('table_capacity');
    if (tableId != null && tableNum != null && tableCapacity != null) {
      return TableResponseDto(
        id: tableId,
        numMesa: tableNum,
        capacity: tableCapacity,
      );
    } else {
      return null;
    }
  }
}
