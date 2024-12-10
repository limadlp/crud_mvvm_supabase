abstract class BackendService {
  Future<List<Map<String, dynamic>>> getData(String table);
  Future<Map<String, dynamic>> createData(
      String table, Map<String, dynamic> data);
  Future<void> updateData(String table, String id, Map<String, dynamic> data);
  Future<void> deleteData(String table, String id);
}
