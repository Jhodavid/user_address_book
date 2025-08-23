import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'infrastructure/datasources/hive_init.dart';
import 'ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInit.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}
