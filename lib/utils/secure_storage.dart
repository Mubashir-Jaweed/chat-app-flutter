import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<void> write(String token, String id) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'id', value: id);
  }

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
