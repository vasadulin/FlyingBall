import 'package:flutter/material.dart';
import '../models/chore_item.dart';

class ChoreProvider with ChangeNotifier {
  final List<ChoreItem> _items = [];

  List<ChoreItem> get items => List.unmodifiable(_items);

  void addChore(ChoreItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeChore(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
