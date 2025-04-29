import 'package:tenant_replication/tenant_replication.dart';

class SyncService {
  static Future<void> sync() async {
    await SyncManager.syncWithServer("http://192.168.0.87:3000");
  }
}
