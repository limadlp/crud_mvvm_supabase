import 'package:crud_mvvm_supabase/app/services/datasource/backend_service.dart';

class ItemRepository {
  final BackendService backendService;

  ItemRepository(this.backendService);

  Future<List<Map<String, dynamic>>> fetchItems() {
    return backendService.getData('items');
  }

  Future<Map<String, dynamic>> addItem(Map<String, dynamic> item) {
    return backendService.createData('items', item);
  }

  Future<void> updateItem(String id, Map<String, dynamic> item) {
    return backendService.updateData('items', id, item);
  }

  Future<void> deleteItem(String id) {
    return backendService.deleteData('items', id);
  }
}
