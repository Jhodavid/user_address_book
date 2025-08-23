import 'package:hive_flutter/adapters.dart';

import '../../config/constants/constants.dart';

class HiveInit {
  static Future<void> ensureInitialized() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>(Constants.usersBoxName);
  }
}