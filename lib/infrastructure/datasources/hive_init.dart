import 'package:hive_flutter/adapters.dart';

import '../../config/constants/constants.dart';

class HiveInit {
  static Future<void> ensureInitialized([HiveInterface? hiveInterface]) async {
    final hive = hiveInterface ?? Hive;
    await hive.initFlutter();
    await hive.openBox<Map>(Constants.usersBoxName);
  }
}