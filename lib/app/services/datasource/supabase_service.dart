import 'package:supabase_flutter/supabase_flutter.dart';
import 'backend_service.dart';

class SupabaseService implements BackendService {
  final SupabaseClient client;

  SupabaseService(this.client);

  @override
  Future<List<Map<String, dynamic>>> getData(String table) async {
    try {
      final response = await client.from(table).select();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> createData(
      String table, Map<String, dynamic> data) async {
    final response = await client.from(table).insert(data);
    if (response.error != null) {
      throw Exception(response.error.message); // Access error directly
    }
    return response.data[0];
  }

  @override
  Future<void> updateData(
      String table, String id, Map<String, dynamic> data) async {
    final response = await client.from(table).update(data).eq('id', id);
    if (response.error != null) {
      throw Exception(response.error.message); // Access error directly
    }
  }

  @override
  Future<void> deleteData(String table, String id) async {
    final response = await client.from(table).delete().eq('id', id);
    if (response.error != null) {
      throw Exception(response.error.message); // Access error directly
    }
  }
}
