import 'package:flutter/foundation.dart';
import '../repositories/item_repository.dart';

class ItemViewModel extends ChangeNotifier {
  final ItemRepository repository;

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items => _items;

  ItemViewModel(this.repository);

  Future<void> loadItems() async {
    try {
      _items = await repository.fetchItems();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading items: $e');
    }
  }

  Future<void> addItem(Map<String, dynamic> item) async {
    try {
      final newItem = await repository.addItem(item);
      _items.add(newItem);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  Future<void> updateItem(String id, Map<String, dynamic> item) async {
    try {
      await repository.updateItem(id, item);
      final index = _items.indexWhere((element) => element['id'] == id);
      if (index != -1) {
        _items[index] = item;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating item: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await repository.deleteItem(id);
      _items.removeWhere((element) => element['id'] == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting item: $e');
    }
  }
}
