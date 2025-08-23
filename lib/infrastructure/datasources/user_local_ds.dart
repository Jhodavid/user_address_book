import 'package:hive/hive.dart';

class UserLocalDS {
  final Box<Map> box;
  UserLocalDS(this.box);

  Future<(Object?, Map<String, dynamic>?)> getUser(String id) async {
    try {
      final raw = box.get(id);
      if (raw == null) return ('NOT_FOUND', null);
      return (null, Map<String, dynamic>.from(raw));
    } catch (e) {
      return (e, null);
    }
  }

  Future<(Object?, List<Map<String, dynamic>>?)> getAll() async {
    try {
      final list = box.values.map((e) => Map<String, dynamic>.from(e)).toList();
      return (null, list);
    } catch (e) {
      return (e, null);
    }
  }

  Future<(Object?, void)> putUser(String id, Map<String, dynamic> data) async {
    try {
      await box.put(id, data);
      return (null, null);
    } catch (e) {
      return (e, null);
    }
  }

  Future<(Object?, void)> deleteUser(String id) async {
    try {
      await box.delete(id);
      return (null, null);
    } catch (e) {
      return (e, null);
    }
  }
}